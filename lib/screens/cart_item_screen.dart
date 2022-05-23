import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pc_parts_app/models/models.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class CartItemScreen extends StatefulWidget {
  final Function(CartItem) onCreate;
  final Function(CartItem) onUpdate;
  final CartItem? originalItem;
  final bool isUpdating;

  const CartItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  State<CartItemScreen> createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  late List<String> _productTypes = List.empty(growable: true);
  late List<String> _productModels = List.empty(growable: true);
  late List _tempList = List.empty(growable: true);
  int? _productIndex;
  int? _modelIndex;
  String? _modelType;
  String? _modelName;
  String _type = '';
  String _name = '';
  double _price = 0.00;
  int _quantity = 0;
  Priority _priority = Priority.NORMAL;

  final TextStyle italicStyle = const TextStyle(
    fontSize: 18,
    fontStyle: FontStyle.italic,
  );

  Future<dynamic> updateTypeList() async {
    _productTypes = List.empty(growable: true);
    final dataString =
        await rootBundle.loadString('assets/sample_data/buy_menu.json');
    final json = jsonDecode(dataString);
    setState(() {
      _tempList = json['parts'];
    });
    for (int i = 0; i < _tempList.length; i++) {
      _productTypes.add(_tempList[i]['type'].toString().toUpperCase());
    }
  }

  Future<dynamic> updateModelList() async {
    _productModels = List.empty(growable: true);
    for (int i = 0; i < _tempList[_productIndex!]['model'].length; i++) {
      _productModels.add(_tempList[_productIndex!]['model'][i]['name']
          .toString()
          .toUpperCase());
    }
  }

  Future<dynamic> getPrice() async {
    _price = double.parse(
        _tempList[_productIndex!]['model'][_modelIndex]['price'].toString());
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        overflow: TextOverflow.visible,
      ),
    );
  }

  void asyncInitState() async {
    await updateTypeList();
  }

  @override
  void initState() {
    updateTypeList().then((value) {
      final originalItem = widget.originalItem;
      if (originalItem != null) {
        _productIndex = 0;
        _type = originalItem.type;
        _modelType = originalItem.type;
        for (int i = 0; i < _tempList.length; i++) {
          if (_tempList[i]['type'].toString().toUpperCase() == _type) {
            _productIndex = i;
            break;
          }
        }
        updateModelList();
        _name = originalItem.name;
        _modelName = originalItem.name;
        _price = originalItem.price;
        _priority = originalItem.priority;
        _quantity = originalItem.quantity;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: make add item to cart screen
    return Scaffold(
      appBar: AppBar(
        title: (widget.originalItem != null && widget.originalItem?.id != '') ? const Text('Edit cart item') : const Text('Add to cart'),
        actions: [
          IconButton(
            onPressed: () {
              if (_modelName != null && _quantity > 0) {
                final cartItem = CartItem(
                  id: widget.originalItem?.id ?? const Uuid().v1(),
                  type: _type,
                  name: _name,
                  priority: _priority,
                  price: _price,
                  quantity: _quantity,
                );

                if (widget.isUpdating) {
                  widget.onUpdate(cartItem);
                } else {
                  widget.onCreate(cartItem);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid entry. Please review all fields.'),
                    duration: Duration(milliseconds: 1500),
                  ),
                );
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Text(
              'Product type:',
              style: italicStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(child: buildTypeDropdown()),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Model:',
              style: italicStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: buildModelDropdown(),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Quantity:',
              style: italicStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: buildQuantityTicker(),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Priority:',
              style: italicStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            buildPriorityChips(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Subtotal:',
                  style: italicStyle,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  NumberFormat('₱#,##0.00').format(_price * _quantity),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTypeDropdown() {
    return DropdownButton<String>(
      isExpanded: true,
      hint: const Text('Please choose a product type'),
      value: _modelType,
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      onChanged: (String? newValue) {
        setState(() {
          _modelType = newValue!;
          if (_modelName != null) {
            _modelName = null;
            _quantity = 0;
          }
          _type = _modelType!;
          _productIndex = _productTypes.indexOf(newValue);
          updateModelList();
        });
      },
      items: _productTypes.map(buildMenuItem).toList(),
    );
  }

  Widget buildModelDropdown() {
    return DropdownButton<String>(
      isExpanded: true,
      hint: const Text('Please choose a model'),
      value: _modelName,
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      onChanged: (String? newValue) {
        setState(() {
          _modelName = newValue!;
          _modelIndex = _productModels.indexOf(newValue);
          _name = _modelName!;
          _quantity = 1;
          getPrice();
        });
      },
      items: _productModels.map(buildMenuItem).toList(),
    );
  }

  Widget buildQuantityTicker() {
    return SizedBox(
      width: 150,
      height: 50,
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                if (_quantity > 0) {
                  _quantity -= 1;
                }
              });
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '$_quantity',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _quantity += 1;
              });
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget buildPriorityChips() {
    return Wrap(
      spacing: 10,
      children: [
        ChoiceChip(
          selectedColor: Colors.yellow,
          label: const Text('Low'),
          selected: _priority == Priority.LOW,
          onSelected: (selected) {
            setState(() {
              _priority = Priority.LOW;
            });
          },
        ),
        ChoiceChip(
          selectedColor: Colors.green,
          label: const Text('Normal'),
          selected: _priority == Priority.NORMAL,
          onSelected: (selected) {
            setState(() {
              _priority = Priority.NORMAL;
            });
          },
        ),
        ChoiceChip(
          selectedColor: Colors.red,
          label: const Text('High'),
          selected: _priority == Priority.HIGH,
          onSelected: (selected) {
            setState(() {
              _priority = Priority.HIGH;
            });
          },
        ),
      ],
    );
  }
}
