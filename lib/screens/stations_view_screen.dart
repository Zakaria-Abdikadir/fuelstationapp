import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../db/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/station.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import '../widgets/station_card.dart';
import 'manage_stations_screen.dart';

class StationsViewScreen extends StatefulWidget {
  const StationsViewScreen({super.key});

  @override
  State<StationsViewScreen> createState() => _StationsViewScreenState();
}

class _StationsViewScreenState extends State<StationsViewScreen> {
  final MapController _mapController = MapController();
  Position? _currentPosition;
  List<Station> _stations = [];
  List<Station> _filteredStations = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  bool _mapReady = false;
  final _authService = AuthService.instance;

  @override
  void initState() {
    super.initState();
    _loadStations();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) return;

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (mounted) {
        setState(() {
          _currentPosition = position;
        });

        if (_mapReady) {
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              _mapController.move(
                LatLng(position.latitude, position.longitude),
                13.0,
              );
            }
          });
        }
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  Future<void> _loadStations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final allStations = await DatabaseHelper.instance.getAllStations();
      final currentUser = _authService.currentUser;

      // Filter to show owner's station if they have one, otherwise show all
      List<Station> stationsToShow;
      if (currentUser?.stationId != null) {
        stationsToShow = allStations
            .where((s) => s.id == currentUser!.stationId)
            .toList();
      } else {
        stationsToShow = allStations;
      }

      if (mounted) {
        setState(() {
          _stations = stationsToShow;
          _filteredStations = stationsToShow;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.homeErrorLoadingStations(e.toString())),
          ),
        );
      }
    }
  }

  void _filterStations(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredStations = _stations;
      } else {
        _filteredStations = _stations.where((station) {
          return station.name.toLowerCase().contains(query.toLowerCase()) ||
              station.address.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  double _calculateDistance(Station station) {
    if (_currentPosition == null) return 0.0;
    return Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      station.latitude,
      station.longitude,
    ) / 1000; // Convert to km
  }

  List<Marker> _getMarkers() {
    List<Marker> markers = [];

    // Add current location marker
    if (_currentPosition != null) {
      markers.add(
        Marker(
          point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          width: 40,
          height: 40,
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        ),
      );
    }

    // Add station markers
    for (var station in _filteredStations) {
      markers.add(
        Marker(
          point: LatLng(station.latitude, station.longitude),
          width: 40,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: station.isActive ? AppColors.success : AppColors.error,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(
              Icons.local_gas_station,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      );
    }

    return markers;
  }

  void _recenterMap() {
    if (_currentPosition != null && _mapReady) {
      _mapController.move(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        13.0,
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentUser = _authService.currentUser;
    final isMyStation = currentUser?.stationId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isMyStation ? l10n.stationsViewMyStation : l10n.stationsViewAllStations),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageStationsScreen(),
                ),
              ).then((_) => _loadStations());
            },
            tooltip: l10n.stationsViewAddStation,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: l10n.stationsViewSearchHint,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _filterStations('');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: _filterStations,
                  ),
                ),
                // Map View
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                              initialCenter: _currentPosition != null
                                  ? LatLng(
                                      _currentPosition!.latitude,
                                      _currentPosition!.longitude,
                                    )
                                  : const LatLng(-1.2921, 36.8219),
                              initialZoom: 13.0,
                              minZoom: 5.0,
                              maxZoom: 18.0,
                              onMapReady: () {
                                setState(() {
                                  _mapReady = true;
                                });

                                if (_currentPosition != null && mounted) {
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    if (mounted) {
                                      _mapController.move(
                                        LatLng(
                                          _currentPosition!.latitude,
                                          _currentPosition!.longitude,
                                        ),
                                        13.0,
                                      );
                                    }
                                  });
                                }
                              },
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.fuelstationapp',
                                maxZoom: 19,
                              ),
                              MarkerLayer(
                                markers: _getMarkers(),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: FloatingActionButton(
                            onPressed: _recenterMap,
                            backgroundColor: AppColors.primary,
                            child: const Icon(Icons.my_location,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Stations List
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.35,
                    minHeight: 200,
                  ),
                  color: AppColors.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    isMyStation
                                        ? l10n.stationsViewMyStation
                                        : l10n.stationsViewAllStations,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (_filteredStations.isNotEmpty)
                                    Text(
                                      l10n.homeStationsFound(_filteredStations.length),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                _loadStations();
                              },
                              icon: const Icon(Icons.refresh, size: 18),
                              label: Text(l10n.homeRefresh),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: _filteredStations.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.local_gas_station,
                                      size: 64,
                                      color: AppColors.textSecondary,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      l10n.homeNoStationsFound,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                itemCount: _filteredStations.length,
                                itemBuilder: (context, index) {
                                  final station = _filteredStations[index];
                                  final distance = _currentPosition != null
                                      ? _calculateDistance(station)
                                      : null;
                                  return SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 32,
                                    child: StationCard(
                                      station: station,
                                      distance: distance,
                                      onSelect: () {
                                        // Navigate to manage station
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ManageStationsScreen(),
                                          ),
                                        ).then((_) => _loadStations());
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

