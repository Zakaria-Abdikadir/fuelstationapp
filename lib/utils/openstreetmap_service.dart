import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/station.dart';

class OpenStreetMapService {
  // Fetch real fuel stations from OpenStreetMap using Overpass API
  static Future<List<Station>> getNearbyFuelStations({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0, // Search radius in kilometers
  }) async {
    try {
      // Overpass API query to find fuel stations (amenity=fuel)
      final query = '''
[out:json][timeout:25];
(
  node["amenity"="fuel"](around:${(radiusKm * 1000).toInt()},$latitude,$longitude);
  way["amenity"="fuel"](around:${(radiusKm * 1000).toInt()},$latitude,$longitude);
  relation["amenity"="fuel"](around:${(radiusKm * 1000).toInt()},$latitude,$longitude);
);
out center;
''';

      final response = await http.post(
        Uri.parse('https://overpass-api.de/api/interpreter'),
        body: query,
        headers: {'Content-Type': 'text/plain'},
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw Exception('Request timeout - OpenStreetMap server is slow. Trying alternative server...');
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final elements = data['elements'] as List?;

        if (elements == null || elements.isEmpty) {
          return [];
        }

        List<Station> stations = [];
        
        for (var element in elements) {
          try {
            final tags = element['tags'] as Map<String, dynamic>?;
            if (tags == null) continue;

            // Get coordinates
            double lat, lon;
            if (element['type'] == 'node') {
              lat = element['lat'] as double;
              lon = element['lon'] as double;
            } else if (element['center'] != null) {
              lat = element['center']['lat'] as double;
              lon = element['center']['lon'] as double;
            } else {
              continue;
            }

            // Extract station information
            final name = tags['name'] as String? ?? 
                        tags['operator'] as String? ?? 
                        'Fuel Station';
            final address = _buildAddress(tags);
            
            // Default prices (OpenStreetMap doesn't store prices, so we use defaults)
            final petrolPrice = 180.0; // Default price, can be updated manually
            final dieselPrice = 170.0;

            stations.add(Station(
              name: name,
              address: address,
              latitude: lat,
              longitude: lon,
              petrolPrice: petrolPrice,
              dieselPrice: dieselPrice,
              isActive: true,
            ));
          } catch (e) {
            // Skip invalid entries
            continue;
          }
        }

        return stations;
      } else if (response.statusCode == 504 || response.statusCode == 503) {
        // Server timeout or unavailable - try alternative server
        debugPrint('Primary server timeout, trying alternative...');
        return await _tryAlternativeServer(latitude, longitude, radiusKm);
      } else {
        debugPrint('Failed to fetch stations: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching OpenStreetMap stations: $e');
      // Try alternative server on error
      try {
        return await _tryAlternativeServer(latitude, longitude, radiusKm);
      } catch (e2) {
        debugPrint('Alternative server also failed: $e2');
        return [];
      }
    }
  }

  // Try alternative Overpass API server
  static Future<List<Station>> _tryAlternativeServer(
    double latitude,
    double longitude,
    double radiusKm,
  ) async {
    try {
      final query = '''
[out:json][timeout:15];
(
  node["amenity"="fuel"](around:${(radiusKm * 1000).toInt()},$latitude,$longitude);
);
out center;
''';

      final response = await http.post(
        Uri.parse('https://overpass.kumi.systems/api/interpreter'),
        body: query,
        headers: {'Content-Type': 'text/plain'},
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final elements = data['elements'] as List?;

        if (elements == null || elements.isEmpty) {
          return [];
        }

        List<Station> stations = [];
        
        for (var element in elements) {
          try {
            final tags = element['tags'] as Map<String, dynamic>?;
            if (tags == null) continue;

            double lat, lon;
            if (element['type'] == 'node') {
              lat = element['lat'] as double;
              lon = element['lon'] as double;
            } else if (element['center'] != null) {
              lat = element['center']['lat'] as double;
              lon = element['center']['lon'] as double;
            } else {
              continue;
            }

            final name = tags['name'] as String? ?? 
                        tags['operator'] as String? ?? 
                        'Fuel Station';
            final address = _buildAddress(tags);
            
            final petrolPrice = 180.0;
            final dieselPrice = 170.0;

            stations.add(Station(
              name: name,
              address: address,
              latitude: lat,
              longitude: lon,
              petrolPrice: petrolPrice,
              dieselPrice: dieselPrice,
              isActive: true,
            ));
          } catch (e) {
            continue;
          }
        }

        return stations;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Alternative server error: $e');
      return [];
    }
  }

  static String _buildAddress(Map<String, dynamic> tags) {
    List<String> addressParts = [];
    
    if (tags['addr:street'] != null) {
      addressParts.add(tags['addr:street'] as String);
    }
    if (tags['addr:housenumber'] != null) {
      addressParts.insert(0, tags['addr:housenumber'] as String);
    }
    if (tags['addr:city'] != null) {
      addressParts.add(tags['addr:city'] as String);
    }
    if (tags['addr:district'] != null && !addressParts.contains(tags['addr:district'])) {
      addressParts.add(tags['addr:district'] as String);
    }

    if (addressParts.isEmpty) {
      // Fallback to operator or brand
      if (tags['operator'] != null) {
        return tags['operator'] as String;
      }
      if (tags['brand'] != null) {
        return tags['brand'] as String;
      }
      return 'Unknown Location';
    }

    return addressParts.join(', ');
  }
}

