class FeeData {
  final String receiptNo;
  final String month;
  final String date;
  final String paymentStatus;
  final String totalAmount;
  final String btnStatus;

  FeeData(this.receiptNo, this.month, this.date, this.paymentStatus,
      this.totalAmount, this.btnStatus);
}

List<FeeData> fee = [
  FeeData('90871', '5', '8 Nov 2020', 'Pending', '35000₹', 'PAY NOW'),
  FeeData('90870', '4', '8 Sep 2020', 'Paid', '35000₹', 'COMPLETE'),
  FeeData('908869', '3', '8 Aug 2020', 'Paid', '35000₹', 'COMPLETE'),
];
