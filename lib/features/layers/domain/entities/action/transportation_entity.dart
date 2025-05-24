import 'package:ch4nge/features/layers/domain/entities/action/action_entity.dart';

class TransportationEntity implements ActionEntity {
  TransportationEntity({
    required this.option,
    required this.vehicle,
    required this.location,
    required this.distance,
    required this.duration,
    required this.distanceUnit,
    required this.durationUnit,
    this.fuelType,
    this.fuelConsumption,
    this.fuelConsumptionUnit,
    this.numberOfPassengers,
    this.publicTransportType,
  });

  @override
  final String option;
  final String vehicle;
  @override
  final List<double> location;
  final double distance;
  final double duration;
  final String distanceUnit;
  final String durationUnit;
  
  // Private Vehicle specific fields
  final String? fuelType;
  final double? fuelConsumption; 
  final String? fuelConsumptionUnit; // L/100km, mpg
  final int? numberOfPassengers;

  // Public Transport specific fields
  final String? publicTransportType; 

  factory TransportationEntity.activeCommute({
    required String vehicle,
    required List<double> location,
    required double distance,
    required double duration,
    required String distanceUnit,
    required String durationUnit,
  }) {
    return TransportationEntity(
      option: "Active Commute",
      vehicle: vehicle,
      location: location,
      distance: distance,
      duration: duration,
      distanceUnit: distanceUnit,
      durationUnit: durationUnit,
    );
  }

  factory TransportationEntity.privateVehicle({
    required List<double> location,
    required double distance,
    required double duration,
    required String distanceUnit,
    required String durationUnit,
    required String fuelType,
    double? fuelConsumption,
    String? fuelConsumptionUnit,
    int? numberOfPassengers,
  }) {
    return TransportationEntity(
      option: "Private Vehicle",
      vehicle: fuelType,
      location: location,
      distance: distance,
      duration: duration,
      distanceUnit: distanceUnit,
      durationUnit: durationUnit,
      fuelType: fuelType,
      fuelConsumption: fuelConsumption,
      fuelConsumptionUnit: fuelConsumptionUnit,
      numberOfPassengers: numberOfPassengers,
    );
  }

  factory TransportationEntity.publicTransport({
    required String publicTransportType,
    required List<double> location,
    required double distance,
    required double duration,
    required String distanceUnit,
    required String durationUnit,
  }) {
    return TransportationEntity(
      option: "Public Transport",
      vehicle: publicTransportType,
      location: location,
      distance: distance,
      duration: duration,
      distanceUnit: distanceUnit,
      durationUnit: durationUnit,
      publicTransportType: publicTransportType,
    );
  }

  // Helper method to get transport mode display name
  String get transportModeDisplay {
    switch (option) {
      case "Active Commute":
        return vehicle;
      case "Private Vehicle":
        return "$fuelType Vehicle";
      case "Public Transport":
        return publicTransportType ?? vehicle;
      default:
        return vehicle;
    }
  }

  // Helper method to check if this is an eco-friendly transport mode
  bool get isEcoFriendly {
    switch (option) {
      case "Active Commute":
        return true; // Walking, cycling, e-scooter are eco-friendly
      case "Private Vehicle":
        return fuelType == "Electric" || fuelType == "Hybrid";
      case "Public Transport":
        return true; // Public transport is generally more eco-friendly
      default:
        return false;
    }
  }

  // Helper method to calculate estimated CO2 emissions (simplified calculation)
  double? get estimatedCO2Emissions {
    switch (option) {
      case "Active Commute":
        return 0.0; // No emissions for active transport
      case "Private Vehicle":
        if (fuelConsumption != null && distance > 0) {
          // Simplified calculation: L/100km * distance/100 * CO2 factor
          double fuelUsed = (fuelConsumption! * distance) / 100;
          switch (fuelType) {
            case "Gasoline":
              return fuelUsed * 2.31; // kg CO2 per liter of gasoline
            case "Diesel":
              return fuelUsed * 2.68; // kg CO2 per liter of diesel
            case "Electric":
              return fuelUsed * 0.5; // Simplified for electric (varies by grid)
            case "Hybrid":
              return fuelUsed * 1.5; // Simplified for hybrid
            default:
              return null;
          }
        }
        return null;
      case "Public Transport":
        // Simplified emissions per km for different public transport
        switch (publicTransportType) {
          case "Bus":
            return distance * 0.089; // kg CO2 per km
          case "Metro/Subway":
            return distance * 0.028; // kg CO2 per km
          case "Train":
            return distance * 0.041; // kg CO2 per km
          case "Tram":
            return distance * 0.029; // kg CO2 per km
          default:
            return distance * 0.05; // Average
        }
      default:
        return null;
    }
  }

  @override
  String toString() {
    return 'TransportationEntity(option: $option, vehicle: $vehicle, '
        'distance: $distance $distanceUnit, duration: $duration $durationUnit, '
        'fuelType: $fuelType, passengers: $numberOfPassengers, '
        'publicTransportType: $publicTransportType, '
        'estimatedCO2: ${estimatedCO2Emissions?.toStringAsFixed(2)} kg)';
  }
}