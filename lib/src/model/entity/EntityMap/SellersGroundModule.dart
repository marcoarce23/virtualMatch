import 'dart:ui';

class SellersGroundModule {
  final String nameProduct;
  final String detailProduct;
  final String locationProduct;
  final double price;
  final double discount;
  final String image;
  final double meters;
  final Color colorNews;
  final String descriptionNews;

  const SellersGroundModule({
    this.nameProduct,
    this.detailProduct,
    this.price,
    this.discount,
    this.image,
    this.locationProduct,
    this.meters,
    this.colorNews,
    this.descriptionNews,
  });
}
