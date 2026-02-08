import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../models/experience_model.dart';

abstract class PortfolioRemoteDataSource {
  Future<List<ProjectModel>> getProjects();
  Future<List<SkillCategoryModel>> getSkillCategories();
  Future<List<ExperienceModel>> getExperiences();
}

class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource {
  final FirebaseFirestore firestore;

  PortfolioRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ProjectModel>> getProjects() async {
    final snapshot = await firestore.collection('projects').get();
    return snapshot.docs
        .map((doc) => ProjectModel.fromFirestore(doc.data()))
        .toList();
  }

  @override
  Future<List<SkillCategoryModel>> getSkillCategories() async {
    final snapshot = await firestore.collection('skills').get();
    return snapshot.docs
        .map((doc) => SkillCategoryModel.fromFirestore(doc.data()))
        .toList();
  }

  @override
  Future<List<ExperienceModel>> getExperiences() async {
    final snapshot = await firestore
        .collection('experience')
        .orderBy('period', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => ExperienceModel.fromFirestore(doc.data()))
        .toList();
  }
}
