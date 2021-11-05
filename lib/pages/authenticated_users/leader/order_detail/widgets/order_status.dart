import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';

class OrderStatus extends StatelessWidget {
  final int doneStep;

  const OrderStatus({Key? key, this.doneStep = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: orderStatusDetail(
                  statusTitle: 'Xác nhận \nđơn hàng',
                  statusValue: doneStep >= 1,
                  size: _size,
                  sizeIcon: 18,
                ),
              ),
              Expanded(
                flex: 1,
                child: orderStatusDetail(
                  statusTitle: 'Trường phòng \nduyệt đơn',
                  statusValue: doneStep >= 2,
                  size: _size,
                  sizeIcon: 18,
                ),
              ),
              Expanded(
                flex: 1,
                child: orderStatusDetail(
                  statusTitle: 'Quản lý \nduyệt đơn',
                  statusValue: doneStep >= 3,
                  size: _size,
                  sizeIcon: 18,
                ),
              ),
              Expanded(
                flex: 1,
                child: orderStatusDetail(
                  statusTitle: 'Hoàn thành \nđơn hàng',
                  statusValue: doneStep >= 4,
                  size: _size,
                  sizeIcon: 18,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Spacer(
                  flex: 1,
                ),
                const SizedBox(
                  width: 18,
                ),
                Expanded(
                  flex: 2,
                  child: doneStep >= 2
                      ? statusBar(status: 'done')
                      : statusBar(status: 'inprogress'),
                ),
                const SizedBox(
                  width: 18,
                ),
                Expanded(
                  flex: 2,
                  child: doneStep >= 3
                      ? statusBar(status: 'done')
                      : doneStep == 2
                          ? statusBar(status: 'inprogress')
                          : statusBar(),
                ),
                const SizedBox(
                  width: 18,
                ),
                Expanded(
                  flex: 2,
                  child: doneStep == 4
                      ? statusBar(status: 'done')
                      : doneStep == 3
                          ? statusBar(status: 'inprogress')
                          : statusBar(),
                ),
                const SizedBox(
                  width: 18,
                ),
                const Spacer(
                  flex: 1,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  statusBar({String? status}) {
    return status == 'done'
        ? Container(
            height: 2,
            color: primaryColor,
          )
        : status == 'inprogress'
            ? const SizedBox(
                height: 2,
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    primaryColor,
                  ),
                  backgroundColor: Color(0xFFD1C1E0),
                ),
              )
            : Container(
                height: 2,
                color: const Color(0xFFD1C1E0),
              );
  }

  orderStatusDetail({
    required String statusTitle,
    required bool statusValue,
    required Size size,
    required double sizeIcon,
  }) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  CircleAvatar(
                    backgroundColor:
                        statusValue ? primaryColor : const Color(0xFFC5A6E2),
                    radius: 9,
                    child: Icon(
                      statusValue
                          ? Icons.check_circle_outline_rounded
                          : Icons.remove_circle_outline,
                      size: sizeIcon,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 75,
              child: Text(
                statusTitle,
                textAlign: TextAlign.center,
                style: h6.copyWith(
                  color: statusValue ? primaryColor : const Color(0xFFAC7ED8),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
}
