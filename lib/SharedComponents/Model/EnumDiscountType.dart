enum EnumDiscountType { Fixed, Percentage }

EnumDiscountType getDiscountTypeFromString(String discountType) {
  if (discountType == "FIXED") {
    return EnumDiscountType.Fixed;
  } else {
    return EnumDiscountType.Percentage;
  }
}
