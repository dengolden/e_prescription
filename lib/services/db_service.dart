import 'package:e_prescription/models/obat.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbService {
  final SupabaseClient _client;

  DbService(this._client);

  Future<Map<String, dynamic>?> getUserNameAndSip(String userId) async {
    final response = await _client
        .from('users')
        .select('name, sip')
        .eq('uid', userId)
        .maybeSingle();
    return response;
  }

  Future<int> addPatient(String name, String gender, String age, String address,
      String patientType) async {
    final response = await _client
        .from('patients')
        .insert({
          'name': name,
          'gender': gender,
          'age': age,
          'address': address,
          'patientType': patientType,
          'user_id': _client.auth.currentUser!.id,
        })
        .select()
        .single();
    return response['id'];
  }

  Future<void> addPrescription(
      String noResep, int patientId, List<Obat> medications) async {
    final response = await _client
        .from('prescriptions')
        .insert({
          'no_resep': noResep,
          'patient_id': patientId,
          'user_id': _client.auth.currentUser!.id, // Menyimpan user_id
          'created_at': DateTime.now().toUtc().toIso8601String(),
        })
        .select()
        .single();
    if (response.containsKey('error')) {
      print('Error adding prescription: ${response['error']}');
      throw Exception(
        response['error'],
      );
    }
    final prescriptionId = response['id'];

    for (var medication in medications) {
      final medResponse = await _client.from('medications').insert({
        'prescription_id': prescriptionId,
        'name': medication.nama,
        'quantity': medication.jumlah,
        'dosage': medication.dosis,
        'user_id': _client.auth.currentUser!.id, // Menyimpan user_id
      });
      if (medResponse.containsKey('error')) {
        print('Error adding medication: ${medResponse['error']}');
        throw Exception(medResponse['error']);
      }
    }
    final countResponse = await _client.from('prescriptions').select('*');
    final count = countResponse.length;
    if (count > 5) {
      final oldestPrescriptionResponse = await _client
          .from('prescriptions')
          .select()
          .order('created_at', ascending: true)
          .limit(1)
          .single();
      final oldestPrescriptionId = oldestPrescriptionResponse['id'];
      await _client
          .from('prescriptions')
          .delete()
          .eq('id', oldestPrescriptionId);
    }
  }
}
