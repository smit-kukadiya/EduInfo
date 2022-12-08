class EventsData {
  final String subjectName;
  final String topicName;
  final String assignDate;
  final String status;

  EventsData(this.subjectName, this.topicName, this.assignDate, this.status);
}

List<EventsData> assignment = [
  EventsData('Technical', 'Techmanjri', 'Jan 2021', 'Pending'),
  EventsData('Non-Technical', 'Khelmanjri', 'None', 'Coming Soon'),
  EventsData('Non-Technical', 'Kalamanjri', '24 Sep 2021', 'Completed'),
  //EventsData('Mathematics', 'Algebra', '17 Sep 2021', '30 Sep 2021', 'Pending'),
];
