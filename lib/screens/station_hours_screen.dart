import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/station.dart';
import '../models/station_hours.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';

class StationHoursScreen extends StatefulWidget {
  const StationHoursScreen({super.key});

  @override
  State<StationHoursScreen> createState() => _StationHoursScreenState();
}

class _StationHoursScreenState extends State<StationHoursScreen> {
  List<Station> _stations = [];
  Station? _selectedStation;
  List<StationHours> _hours = [];
  bool _isLoading = true;
  final _authService = AuthService.instance;
  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    _loadStations();
  }

  Future<void> _loadStations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final currentUser = _authService.currentUser;
      final allStations = await DatabaseHelper.instance.getAllStations();
      
      if (currentUser?.stationId != null) {
        _stations = allStations
            .where((s) => s.id == currentUser!.stationId)
            .toList();
        if (_stations.isNotEmpty) {
          _selectedStation = _stations.first;
          _loadHours();
        }
      } else {
        _stations = allStations;
        if (_stations.isNotEmpty) {
          _selectedStation = _stations.first;
          _loadHours();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading stations: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadHours() async {
    if (_selectedStation == null) return;

    try {
      final hours = await DatabaseHelper.instance
          .getStationHoursByStationId(_selectedStation!.id!);
      setState(() {
        _hours = hours;
      });
    } catch (e) {
      debugPrint('Error loading hours: $e');
    }
  }

  Future<void> _editHours(String dayOfWeek) async {
    if (_selectedStation == null) return;

    final existing = _hours.firstWhere(
      (h) => h.dayOfWeek == dayOfWeek,
      orElse: () => StationHours(
        stationId: _selectedStation!.id!,
        dayOfWeek: dayOfWeek,
      ),
    );

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationHoursFormScreen(hours: existing),
      ),
    );

    if (result == true) {
      _loadHours();
    }
  }

  String _getDayLabel(String day, AppLocalizations l10n) {
    switch (day) {
      case 'Monday':
        return l10n.stationHoursMonday;
      case 'Tuesday':
        return l10n.stationHoursTuesday;
      case 'Wednesday':
        return l10n.stationHoursWednesday;
      case 'Thursday':
        return l10n.stationHoursThursday;
      case 'Friday':
        return l10n.stationHoursFriday;
      case 'Saturday':
        return l10n.stationHoursSaturday;
      case 'Sunday':
        return l10n.stationHoursSunday;
      default:
        return day;
    }
  }

  String _getHoursDisplay(StationHours hours) {
    if (hours.isClosed) {
      return 'Closed';
    }
    if (hours.isOpen24Hours) {
      return '24 Hours';
    }
    if (hours.openTime != null && hours.closeTime != null) {
      return '${hours.openTime} - ${hours.closeTime}';
    }
    return 'Not Set';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.stationHoursTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _stations.isEmpty
              ? Center(
                  child: Text(
                    'No stations available',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                )
              : Column(
                  children: [
                    if (_stations.length > 1)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: DropdownButtonFormField<Station>(
                          value: _selectedStation,
                          decoration: InputDecoration(
                            labelText: 'Select Station',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: _stations.map((station) {
                            return DropdownMenuItem(
                              value: station,
                              child: Text(station.name),
                            );
                          }).toList(),
                          onChanged: (station) {
                            setState(() {
                              _selectedStation = station;
                            });
                            _loadHours();
                          },
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _daysOfWeek.length,
                        itemBuilder: (context, index) {
                          final day = _daysOfWeek[index];
                          final hours = _hours.firstWhere(
                            (h) => h.dayOfWeek == day,
                            orElse: () => StationHours(
                              stationId: _selectedStation!.id!,
                              dayOfWeek: day,
                            ),
                          );
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            child: ListTile(
                              title: Text(
                                _getDayLabel(day, l10n),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(_getHoursDisplay(hours)),
                              trailing: const Icon(Icons.edit),
                              onTap: () => _editHours(day),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

// Station Hours Form Screen
class StationHoursFormScreen extends StatefulWidget {
  final StationHours hours;

  const StationHoursFormScreen({super.key, required this.hours});

  @override
  State<StationHoursFormScreen> createState() => _StationHoursFormScreenState();
}

class _StationHoursFormScreenState extends State<StationHoursFormScreen> {
  bool _isOpen24Hours = false;
  bool _isClosed = false;
  TimeOfDay? _openTime;
  TimeOfDay? _closeTime;

  @override
  void initState() {
    super.initState();
    _isOpen24Hours = widget.hours.isOpen24Hours;
    _isClosed = widget.hours.isClosed;
    if (widget.hours.openTime != null) {
      final parts = widget.hours.openTime!.split(':');
      _openTime = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }
    if (widget.hours.closeTime != null) {
      final parts = widget.hours.closeTime!.split(':');
      _closeTime = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }
  }

  Future<void> _selectOpenTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _openTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _openTime = time;
      });
    }
  }

  Future<void> _selectCloseTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _closeTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _closeTime = time;
      });
    }
  }

  Future<void> _saveHours() async {
    try {
      final hours = StationHours(
        id: widget.hours.id,
        stationId: widget.hours.stationId,
        dayOfWeek: widget.hours.dayOfWeek,
        openTime: _isOpen24Hours || _isClosed
            ? null
            : _openTime != null
                ? '${_openTime!.hour.toString().padLeft(2, '0')}:${_openTime!.minute.toString().padLeft(2, '0')}'
                : null,
        closeTime: _isOpen24Hours || _isClosed
            ? null
            : _closeTime != null
                ? '${_closeTime!.hour.toString().padLeft(2, '0')}:${_closeTime!.minute.toString().padLeft(2, '0')}'
                : null,
        isOpen24Hours: _isOpen24Hours,
        isClosed: _isClosed,
      );

      if (widget.hours.id == null) {
        await DatabaseHelper.instance.insertStationHours(hours);
      } else {
        await DatabaseHelper.instance.updateStationHours(hours);
      }

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hours updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving hours: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.stationHoursManageHours),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.hours.dayOfWeek,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: Text(l10n.stationHoursClosed),
              value: _isClosed,
              onChanged: (value) {
                setState(() {
                  _isClosed = value;
                  if (value) {
                    _isOpen24Hours = false;
                  }
                });
              },
            ),
            SwitchListTile(
              title: Text(l10n.stationHours24Hours),
              value: _isOpen24Hours,
              onChanged: (value) {
                setState(() {
                  _isOpen24Hours = value;
                  if (value) {
                    _isClosed = false;
                  }
                });
              },
            ),
            if (!_isOpen24Hours && !_isClosed) ...[
              const SizedBox(height: 16),
              ListTile(
                title: Text(l10n.stationHoursOpenTime),
                subtitle: Text(
                  _openTime?.format(context) ?? 'Not set',
                ),
                trailing: const Icon(Icons.access_time),
                onTap: _selectOpenTime,
              ),
              ListTile(
                title: Text(l10n.stationHoursCloseTime),
                subtitle: Text(
                  _closeTime?.format(context) ?? 'Not set',
                ),
                trailing: const Icon(Icons.access_time),
                onTap: _selectCloseTime,
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveHours,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(l10n.commonSave),
            ),
          ],
        ),
      ),
    );
  }
}

