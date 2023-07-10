final items = [
  Item(emoji: '🐔', title: 'Twitter', url: 'https://twitter.com/teshi04'),
  Item(emoji: '🐙', title: 'GitHub', url: 'https://github.com/teshi04'),
  Item(emoji: '📝', title: 'note', url: 'https://note.com/teshi04'),
  Item(emoji: '👣', title: 'Blog', url: 'https://teshi04.hatenablog.com/'),
];

class Item {
  final String emoji;
  final String title;
  final String url;

  Item({
    required this.emoji,
    required this.title,
    required this.url,
  });
}
