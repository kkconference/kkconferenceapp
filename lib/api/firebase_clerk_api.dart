import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kk_conferences/model/booking_model.dart';
import 'package:kk_conferences/model/confress_model.dart';
import 'package:kk_conferences/model/staff_model.dart';
import 'package:uuid/uuid.dart';

class FirebaseMemberApi {
  static const collectionName = "Staff";

//
  createroom() async {
    var uuid = Uuid();
    RoomInfo info = RoomInfo(
      price: 400,
      address: "unknown",
      name: "Conference Room 1",
    );

    info.roomNo = uuid.v4();
    FirebaseFirestore.instance
        .collection("RoomPrice")
        .add(info.toJson())
        .then((value) {});
    return StaffResult(status: 1, msg: "User Created successfully");
  }

  Future<QuerySnapshot> getRoomInfo(String roomid) async {
    return await FirebaseFirestore.instance
        .collection("RoomPrice")
        .where("roomNo", isEqualTo: roomid)
        .get()
        .then((value) {
      return value;
    });
  }

  createStaffModel(StaffModel staffmodel) async {
    bool user_flag = await checkUserExist(staffmodel);
    if (user_flag == true) {
      return StaffResult(status: 0, msg: "User Already Exist");
    }

    var uuid = Uuid();
    staffmodel.staffid = uuid.v4();
    FirebaseFirestore.instance
        .collection(collectionName)
        .add(staffmodel.toJson())
        .then((value) {});
    return StaffResult(status: 1, msg: "User Created successfully");
  }

  Future<QuerySnapshot> getStaffModel(StaffModel staffmodel) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .where("email", isEqualTo: staffmodel.email)
        .get()
        .then((value) {
      return value;
    });
  }

  Future<bool> checkUserExist(StaffModel staffmodel) async {
    var snapshot = await getStaffModel(staffmodel);
    print("size of data is : ${snapshot.size}");

    if (snapshot != null) {
      if (snapshot.size > 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return null;
    }
  }

  signIn(StaffModel staffmodel) async {
    QuerySnapshot snapshot = await getStaffModel(staffmodel);
    try {
      QueryDocumentSnapshot result = snapshot.docs.first;
      if (result.exists) {
        if (staffmodel.password == result.get("password") &&
            staffmodel.email == result.get("email")) {
          return StaffResult(
              status: 1,
              msg: "Login Successfull",
              staffModel: StaffModel.fromJson(result.data()));
        } else {
          return StaffResult(status: 0, msg: "User Autharisation Failed");
        }
      }
    } catch (e) {
      return StaffResult(status: 0, msg: "User not found");
    }
  }

  // get selected date booking
  Future<QuerySnapshot> getSelectedDateBookings({BookingModel model}) async {
    return await FirebaseFirestore.instance
        .collection("Bookings")
        .where("bookingDate", isEqualTo: model.bookingDate)
        .orderBy("createdon")
        .get()
        .then((value) {
      return value;
    });
  }

  Future<QuerySnapshot> getCustomerDetails(BookingModel model) async {
    return await FirebaseFirestore.instance
        .collection("Customers")
        .where("customer_id", isEqualTo: model.bookingUserId)
        .get()
        .then((value) {
      return value;
    });
  }

  Future<QuerySnapshot> approveBooking(BookingModel e) async {
    return await FirebaseFirestore.instance
        .collection("Bookings")
        .where("bookingId", isEqualTo: e.bookingId)
        .get()
        .then((value) {
      return value;
    });
  }

/* Cancellaton steps here */

  Future<QuerySnapshot> deleteCancelBookingEntry(BookingModel model) async {
    return await FirebaseFirestore.instance
        .collection("Bookings")
        .where("bookingId", isEqualTo: model.bookingId)
        .get()
        .then((value) {
      return value;
    });
  }

  Future<QuerySnapshot> addCancelBooking(BookingModel model) async {
    return FirebaseFirestore.instance
        .collection("CancelBookings")
        .add(model.toJson())
        .then((value) {});
  }

  Future<QuerySnapshot> getCancellationRequests() async {
    return await FirebaseFirestore.instance
        .collection("CancelBookings")
        .where("iscancel", isEqualTo: false)
        .orderBy("createdon", descending: true)
        .limit(200)
        .get()
        .then((value) {
      return value;
    });
  }

  Future<QuerySnapshot> getBookingEntry(BookingModel model) async {
    return await FirebaseFirestore.instance
        .collection("CancelBookings")
        .where("bookingId", isEqualTo: model.bookingId).limit(1)
        .get()
        .then((value) {
      return value;
    });
  }

  Future<QuerySnapshot> addRefundEntry(BookingModel model) async {
    return FirebaseFirestore.instance
        .collection("Refund")
        .add(model.toJson())
        .then((value) {});
  }

  Future<QuerySnapshot>  getCancellationBookingid(BookingModel model)async {
    return await FirebaseFirestore.instance
        .collection("CancelBookings")
        .where("bookingId", isEqualTo: model.bookingId).limit(1)
        .get()
        .then((value) {
      return value;
    });

  }

  Future<QuerySnapshot> getPaymentDetails(String date)async {

    return await FirebaseFirestore.instance
        .collection("Bookings")
        .where("bookingDate", isEqualTo: date).where("bookingStatus", isEqualTo: true)
        .orderBy("createdon",descending: false)
        .get()
        .then((value) {
      return value;
    });
  }


}
