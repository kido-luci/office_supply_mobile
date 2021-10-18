import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            orderStatusDetail(
              statusTitle: 'Xác nhận đơn hàng',
              statusValue: true,
              statusStep: 1,
              isLastStatus: false,
            ),
            orderStatusDetail(
              statusTitle: 'Chấp thuận đơn hàng của trưởng phòng',
              statusValue: false,
              statusStep: 2,
              isLastStatus: false,
            ),
            orderStatusDetail(
              statusTitle: 'Chấp thuận đơn hàng của quản lý',
              statusValue: false,
              statusStep: 3,
              isLastStatus: false,
            ),
            orderStatusDetail(
              statusTitle: 'Hoàn thành đơn hàng',
              statusValue: false,
              statusStep: 4,
              isLastStatus: true,
            ),
          ],
        ),
      );

  orderStatusDetail(
          {required String statusTitle,
          required bool statusValue,
          required int statusStep,
          required bool isLastStatus}) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Bước ${statusStep.toString()}',
            style: h6.copyWith(
              color: statusValue ? Colors.black : lightGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor:
                      statusValue ? primaryColor : primaryLightColor,
                  radius: 6,
                ),
                Container(
                  height: isLastStatus ? 0 : 25,
                  width: 2,
                  color: statusValue ? primaryColor : primaryLightColor,
                )
              ],
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
        ],
      );
}
