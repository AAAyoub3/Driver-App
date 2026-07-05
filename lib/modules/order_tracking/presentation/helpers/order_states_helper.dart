enum OrderStates {
  firstState(
    buttonText: "Arrived at Pickup point",
    statusText: "Accepted",
    value: 0,
  ),
  secondState(buttonText: "Start deliver", statusText: "Picked", value: 1),
  thirdState(
    buttonText: "Arrived to the user",
    statusText: "Out for delivery",
    value: 2,
  ),
  fourthState(
    buttonText: "Delivered to the user",
    statusText: "Arrived",
    value: 3,
  ),
  fifthState(
    buttonText: "Delivered to the user",
    statusText: "Delivered",
    value: 4,
  );

  final String buttonText;
  final String statusText;
  final int value;

  const OrderStates({
    required this.buttonText,
    required this.statusText,
    required this.value,
  });
}

OrderStates? getOrderStateFromStatus(String? status) {
  if (status == null) return null;

  return OrderStates.values.firstWhere(
    (e) => e.statusText == status,
    orElse: () => OrderStates.firstState,
  );
}