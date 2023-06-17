class BasePaginationEntity {
  int currentPage;
  List<dynamic> data;
  String firstPageUrl;
  int from;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;

  BasePaginationEntity(this.data, this.currentPage, this.nextPageUrl, this.firstPageUrl, this.perPage, this.prevPageUrl, this.from, this.to, this.path);
}
