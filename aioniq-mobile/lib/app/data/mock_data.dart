import 'dart:math';

// Simulates the sensor data coming from the backend
Map<String, dynamic> mockSensorData() {
  // Create some random, but realistic, data to make the UI feel live
  final random = Random();
  return {
    'ph': 6.8 + random.nextDouble() * 0.5,
    'kelembaban': 65.0 + random.nextDouble() * 5.0,
    'nutrisi': 850.0 + random.nextDouble() * 50.0,
    'suhu': 25.5 + random.nextDouble() * 2.0,
    'amonia': 0.150 + random.nextDouble() * 0.05,
  };
}

// Simulates the schedule data coming from the backend
List<Map<String, dynamic>> mockScheduleData() {
  // Create some mock schedules for different times
  return [
    {
      'id': 1,
      'title': 'Jadwal Pagi',
      'schedule':
          DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
      'duration': 10,
      'isActive': true,
    },
    {
      'id': 2,
      'title': 'Jadwal Siang',
      'schedule':
          DateTime.now().add(const Duration(hours: 4)).toIso8601String(),
      'duration': 15,
      'isActive': false,
    },
    {
      'id': 3,
      'title': 'Jadwal Malam',
      'schedule':
          DateTime.now().add(const Duration(hours: 8)).toIso8601String(),
      'duration': 20,
      'isActive': true,
    }
  ];
}
