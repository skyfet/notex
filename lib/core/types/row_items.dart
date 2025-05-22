abstract class RowItem<T> {
  const RowItem(this.value);

  final T value;
}

class HeaderItem extends RowItem<String> {
  const HeaderItem(super.value);
}

class LoaderItem extends RowItem<void> {
  const LoaderItem() : super(null);
}
