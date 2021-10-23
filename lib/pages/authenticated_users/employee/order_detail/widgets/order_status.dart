import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: 300,
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: orderStatusDetail(
              statusTitle: 'Xác nhận đơn hàng',
              statusValue: true,
              statusStep: 1,
              isFristStatus: true,
              isLastStatus: false,
              size: _size,
            ),
          ),
          Expanded(
            flex: 1,
            child: orderStatusDetail(
              statusTitle: 'Chấp thuận đơn hàng của trưởng phòng',
              statusValue: false,
              statusStep: 2,
              isFristStatus: false,
              isLastStatus: false,
              size: _size,
            ),
          ),
          Expanded(
            flex: 1,
            child: orderStatusDetail(
              statusTitle: 'Chấp thuận đơn hàng của quản lý',
              statusValue: false,
              statusStep: 3,
              isFristStatus: false,
              isLastStatus: false,
              size: _size,
            ),
          ),
          Expanded(
            flex: 1,
            child: orderStatusDetail(
              statusTitle: 'Hoàn thành đơn hàng',
              statusValue: false,
              statusStep: 4,
              isFristStatus: false,
              isLastStatus: true,
              size: _size,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  orderStatusDetail({
    required String statusTitle,
    required bool statusValue,
    required int statusStep,
    required bool isFristStatus,
    required bool isLastStatus,
    required Size size,
  }) =>
      Container(
        color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 2,
                        // width: size.width / 4 - 12,
                        color: statusValue ? primaryColor : primaryLightColor,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor:
                          statusValue ? primaryColor : primaryLightColor,
                      radius: 6,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 2,
                        // width: size.width / 4 - 12,
                        color: statusValue ? primaryColor : primaryLightColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Text(
                statusTitle,
                style: h6.copyWith(
                  color:
                      statusValue ? primaryColor : primaryLightColorTransparent,
                ),
              ),
            ),
            // Text(
            //   'Bước ${statusStep.toString()}',
            //   style: h6.copyWith(
            //     color: statusValue ? Colors.black : lightGrey,
            //   ),
            //),
          ],
        ),
      );
}
