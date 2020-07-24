class Category {
  final String idCategory;
  final String nameCategory;
  final String imageCategory;

  const Category({
    this.idCategory,
    this.nameCategory,
    this.imageCategory,
  });
}

class ProductCategory {
  final bool favorite;
  final String nameCategory;
  final String nameProduct;
  final double priceProduct;
  final double priceProductDiscount;
  final double ranking;
  final String imageCategory;

  const ProductCategory({
    this.nameCategory,
    this.imageCategory,
    this.favorite,
    this.nameProduct,
    this.priceProduct,
    this.priceProductDiscount,
    this.ranking,
  });
}
