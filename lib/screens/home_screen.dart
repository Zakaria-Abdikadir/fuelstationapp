import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../db/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/station.dart';
import '../navigation/app_drawer.dart';
import '../navigation/bottom_navbar.dart';
import '../utils/app_colors.dart';
import '../utils/openstreetmap_service.dart';
import '../widgets/station_card.dart';
import 'fuel_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(Station)? onStationSelected;
  
  const HomeScreen({super.key, this.onStationSelected});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _initialZoom = 13.0;
  int _currentIndex = 0;
  final MapController _mapController = MapController();
  Position? _currentPosition;
  List<Station> _stations = [];
  List<Station> _filteredStations = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  bool _mapReady = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.homeErrorLocationServicesDisabled),
            ),
          );
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
            final l10n = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.homeErrorLocationDenied),
              ),
            );
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.homeErrorLocationDeniedForever),
            ),
          );
        }
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
        
        // Load real stations after getting location
        await _loadStations();
        
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          
          // Move map to current location after map is rendered
          // Use a small delay to ensure map is initialized
          if (_mapReady) {
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) {
                _mapController.move(
                  LatLng(position.latitude, position.longitude),
                  _initialZoom,
                );
              }
            });
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.homeErrorGettingLocation(e.toString())),
          ),
        );
      }
    }
  }

  Future<void> _loadStations() async {
    try {
      // First load default stations from database
      List<Station> dbStations = await DatabaseHelper.instance.getAllStations();
      
      // If we have user location, fetch real stations from OpenStreetMap
      if (_currentPosition != null) {
        try {
          final realStations = await OpenStreetMapService.getNearbyFuelStations(
            latitude: _currentPosition!.latitude,
            longitude: _currentPosition!.longitude,
            radiusKm: 10.0, // 10km radius
          );
          
          // Combine real stations with database stations (avoid duplicates)
          Set<String> stationNames = {};
          List<Station> allStations = [];
          
          // Add real stations first
          for (var station in realStations) {
            if (!stationNames.contains(station.name.toLowerCase())) {
              allStations.add(station);
              stationNames.add(station.name.toLowerCase());
            }
          }
          
          // Add database stations that aren't duplicates
          for (var station in dbStations) {
            if (!stationNames.contains(station.name.toLowerCase())) {
              allStations.add(station);
              stationNames.add(station.name.toLowerCase());
            }
          }
          
          if (mounted) {
            setState(() {
              _stations = allStations;
              _filteredStations = allStations;
              if (_isLoading) {
                _isLoading = false;
              }
            });
          }
        } catch (e) {
          // If OpenStreetMap fails, use database stations
          debugPrint('Failed to fetch real stations: $e');
          if (mounted) {
            setState(() {
              _stations = dbStations;
              _filteredStations = dbStations;
              if (_isLoading) {
                _isLoading = false;
              }
            });
          }
        }
      } else {
        // No location yet, just use database stations
        if (mounted) {
          setState(() {
            _stations = dbStations;
            _filteredStations = dbStations;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.homeErrorLoadingStations(e.toString())),
          ),
        );
        setState(() {
          _isLoading = false;
        });
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
          child: GestureDetector(
            onTap: () => _onStationSelect(station),
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
        ),
      );
    }

    return markers;
  }

  void _onStationSelect(Station station) {
    if (widget.onStationSelected != null) {
      widget.onStationSelected!(station);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FuelScreen(station: station),
        ),
      );
    }
  }

  void _recenterMap() {
    if (_currentPosition != null && _mapReady) {
      _mapController.move(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        _initialZoom,
      );
    }
  }

  void _onBottomNavTap(int index) {
    // Bottom navigation is handled by MainNavigationScreen
    // This is kept for backward compatibility but won't be used
    if (widget.onStationSelected == null) {
      setState(() {
        _currentIndex = index;
      });
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
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
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
                      hintText: l10n.homeSearchHint,
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
                // OpenStreetMap
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
                                  ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                                  : const LatLng(-1.2921, 36.8219), // Default to Nairobi
                              initialZoom: _initialZoom,
                              minZoom: 5.0,
                              maxZoom: 18.0,
                              onMapReady: () {
                                // Map is ready, now we can safely use the controller
                                setState(() {
                                  _mapReady = true;
                                });
                                
                                // Move to current location if available
                                if (_currentPosition != null && mounted) {
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    if (mounted) {
                                      _mapController.move(
                                        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                                        _initialZoom,
                                      );
                                    }
                                  });
                                }
                              },
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                            child: const Icon(Icons.my_location, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Station Cards List
                Container(
                  height: 300,
                  color: AppColors.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.homeNearbyStations,
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
                            TextButton.icon(
                              onPressed: () {
                                // Refresh stations
                                _loadStations();
                              },
                              icon: const Icon(Icons.refresh),
                              label: Text(l10n.homeRefresh),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: _filteredStations.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    const SizedBox(height: 8),
                                    TextButton(
                                      onPressed: _loadStations,
                                      child: Text(l10n.homeNoStationsFoundAction),
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
                                    width: MediaQuery.of(context).size.width - 32,
                                    child: StationCard(
                                      station: station,
                                      distance: distance,
                                      onSelect: () => _onStationSelect(station),
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
      bottomNavigationBar: widget.onStationSelected == null
          ? BottomNavBar(
              currentIndex: _currentIndex,
              onTap: _onBottomNavTap,
            )
          : null,
    );
  }
}
