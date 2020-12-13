import 'package:fms_flutter/repository/repo_images.dart';

class RepositoryCategory {
  int id;

  String name;
  String comment = '';
  int nbImages = 0;
  int nbCategories;

  RepositoryImage local;
  RepositoryImage network;

  RepositoryCategory(this.id, this.local, this.network,
      {this.nbImages, this.nbCategories, this.comment, this.name});
}
