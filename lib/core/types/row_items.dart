abstract class RowItem<T> {
  const RowItem();
}

class HeaderItem extends RowItem<String> {
  final String text;
  HeaderItem(this.text);
}

class LoaderItem extends RowItem {
  const LoaderItem();
}
