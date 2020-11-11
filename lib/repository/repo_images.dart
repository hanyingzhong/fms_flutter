class RepositoryImagePair {
  int id;

  String name;
  String comment;

  RepositoryImage local;
  RepositoryImage network;

  RepositoryImagePair(this.id, this.local, this.network);
}

class RepositoryImage {
  RepositoryImageDesc thumb;
  RepositoryImageDesc large;

  RepositoryImage(this.thumb, this.large);
}

class RepositoryImageDesc {
  int height;
  int width;
  String location;

  RepositoryImageDesc(this.height, this.width, this.location);
}
