class TraineeProgressInstance {
  List<String> milestones = [];
  Map<String, String> metrics = {};

  TraineeProgressInstance(this.milestones, this.metrics);

  @override
  String toString() {
    return "Milestones: $milestones\n"
        "Metrics: $metrics";
  }
}
