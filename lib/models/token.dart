class TokenUserData {
  final String id;
  final String username;
  final String nickname;
  final String avatar;
  final String createdAt;
  final String theme;
  final bool anonymous;
  TokenUserData(this.id, this.username, this.nickname, {
    this.avatar = '',
    this.createdAt = '',
    this.theme = '',
    this.anonymous = false
  });
}