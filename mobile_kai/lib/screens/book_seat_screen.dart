import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/screens/bottom_bar.dart';
import 'package:kai_mobile/screens/load_ticket.dart';
import 'package:kai_mobile/screens/ticket_screen.dart';
import 'package:kai_mobile/utils/app_layout.dart';
import 'package:kai_mobile/utils/app_styles.dart';

class BookSeat extends StatefulWidget {
  final Map? dataJourney;
  const BookSeat(@required this.dataJourney);

  @override
  State<BookSeat> createState() => _BookSeatState();
}

enum SeatState {
  sold,
  available,
  selectedByYou,
}

class Seat {
  final String id;
  final String seat;
  final SeatState state;

  Seat({required this.id, required this.seat, required this.state});
}

class _BookSeatState extends State<BookSeat> {
  Set<SeatNumber> selectedSeats = Set();

  List<Seat> _seats = [];

  List<Seat> _selectedSeats = [];

  getSeat(data) {
    var data2 = data["data"];
    var selectedClass = data["detail"]?["train_fare"]
        .firstWhere((fr) => fr["class"] == data2["class_selected"]);
    var seats = selectedClass?["wagon"]?["wagon_seat"];

    for (var i = 0; i < seats.length; i++) {
      var seat = seats[i];
      if (seat?["passenger_id"] != null) {
        _seats.add(Seat(
            id: "${seat['id']}",
            seat: "${seat['seat']}",
            state: SeatState.sold));
      } else {
        _seats.add(Seat(
            id: "${seat['id']}",
            seat: "${seat['seat']}",
            state: SeatState.available));
      }
    }
  }

  void _onSeatTap(Seat seat) {
    if (seat.state == SeatState.sold) {
      return;
    }
    setState(() {
      if (seat.state == SeatState.available) {
        // if (_selectedSeats.length + 1 >
        //     int.parse(widget.dataJourney?["data"]?["passengerCount"])) {
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: Text("Anda sudah memilih lebih dari jumlah penumpang"),
        //     backgroundColor: Colors.red,
        //   ));
        //   _selectedSeats.clear();
        // } else {
        _seats[_seats.indexOf(seat)] = Seat(
          id: seat.id,
          seat: seat.seat,
          state: SeatState.selectedByYou,
        );
        _selectedSeats.add(seat);
        // }
      } else if (seat.state == SeatState.selectedByYou) {
        _seats[_seats.indexOf(seat)] = Seat(
          id: seat.id,
          seat: seat.id,
          state: SeatState.available,
        );
        _selectedSeats.remove(seat);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSeat(widget.dataJourney);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Kursi ".toUpperCase() +
            widget.dataJourney?["data"]?["class_selected"]),
        backgroundColor: Styles.primaryBold,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            color: Colors.blue,
            margin: EdgeInsets.all(16),
            child: Text(
              "Pintu Gerbong",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 2,
              children: _seats
                  .map(
                    (seat) => GestureDetector(
                      onTap: () => _onSeatTap(seat),
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: seat.state == SeatState.sold
                              ? Colors.grey
                              : seat.state == SeatState.available
                                  ? Colors.green
                                  : Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            seat.seat,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 15,
                  height: 15,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Tidak Tersedia",
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 15,
                  height: 15,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Tersedia",
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 15,
                  height: 15,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Pilihan anda",
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GestureDetector(
                  onTap: () {
                    if (_selectedSeats.length == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Pilih kursi terlebih dahulu"),
                        backgroundColor: Colors.red,
                      ));
                    }
                    // else if (_selectedSeats.length !=
                    //     int.parse(
                    //         widget.dataJourney?["data"]?["passengerCount"])) {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: Text(
                    //         "Sesuaikan dengan jumlah penumpang anda terlebih dahulu"),
                    //     backgroundColor: Colors.red,
                    //   ));
                    // }
                    else {
                      print(_selectedSeats);
                      goRemove(LoadTicket(), context);
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Styles.primaryBold,
                      borderRadius:
                          BorderRadius.circular(AppLayout.getHeight(15)),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Pesan Tiket".toUpperCase(),
                        style: Styles.headLineStyle3
                            .copyWith(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}

class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI &&
        colI == (other as SeatNumber).colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[$rowI][$colI]';
  }
}
