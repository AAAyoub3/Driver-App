abstract interface class ProfileLocalDataSourcesContract {
  Future<String?> getUserTokenFromFSS();
  Future<void> updateUserTokenFromFSS(String token);
}
