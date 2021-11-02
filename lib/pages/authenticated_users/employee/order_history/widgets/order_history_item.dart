import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/order_history_item/order_history_item.dart'
    as order_history_item_object;

class OrderHistoryItem extends StatelessWidget {
  final order_history_item_object.OrderHistoryItem orderHistoryItem;
  final Function(
      {required order_history_item_object.OrderHistoryItem
          orderHistoryItem}) onTap;

  const OrderHistoryItem({
    Key? key,
    required this.orderHistoryItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          onTap.call(orderHistoryItem: orderHistoryItem);
        },
        child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset.zero,
                blurRadius: 3,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Mã đơn hàng: ',
                        style: h6.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: '#' + orderHistoryItem.id.toString(),
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: primaryColor),
                          )
                        ],
                      ),
                    ),
                    Text(
                      DateFormat('kk:mm - dd/MM/yyyy').format(
                        orderHistoryItem.createTime.add(
                          const Duration(hours: 7),
                        ),
                      ),
                      style: h6.copyWith(color: lightGrey, height: 1.5),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Trạng thái đơn hàng',
                      style: h6.copyWith(
                        color: Colors.black,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      orderHistoryItem.orderStatusID == 1
                          ? 'Chờ trưởng phòng duyệt'
                          : orderHistoryItem.orderStatusID == 2
                              ? 'Chờ quản lý duyệt'
                              : orderHistoryItem.orderStatusID == 3
                                  ? 'Hoàn thành đơn hàng'
                                  : 'Đã huỷ đơn hàng',
                      style: h6.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                        //fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
