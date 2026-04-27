import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseScreen extends StatefulWidget {
  const InAppPurchaseScreen({super.key});

  @override
  State<InAppPurchaseScreen> createState() => _InAppPurchaseScreenState();
}

class _InAppPurchaseScreenState extends State<InAppPurchaseScreen> {
  final InAppPurchase _iap = InAppPurchase.instance;
  bool _available = false;
  bool _loading = true;
  List<ProductDetails> _products = [];
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  String? _error;
  int _totalCoins = 0;


  final Set<String> _productIds = {
    'coinsmall2', // Small Coin Pack — 100 coins
    'coinsmall1', // Large Coin Pack — 500 coins
  };


  final Map<String, int> _coinRewards = {
    'coinsmall2': 100,
    'coinsmall1': 500,
  };


  final Map<String, String> _productNames = {
    'coinsmall2': 'Small Coin Pack',
    'coinsmall1': 'Large Coin Pack',
  };

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final available = await _iap.isAvailable();

    if (!available) {
      setState(() {
        _available = false;
        _loading = false;
        _error = 'In-app purchases not available';
      });
      return;
    }

    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () => _subscription?.cancel(),
      onError: (error) {
        setState(() {
          _error = error.toString();
        });
      },
    );

    setState(() {
      _available = available;
    });

    await _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final ProductDetailsResponse response =
      await _iap.queryProductDetails(_productIds);

      if (response.error != null) {
        setState(() {
          _error = response.error!.message;
          _loading = false;
        });
        return;
      }

      if (response.productDetails.isEmpty) {
        setState(() {
          _error = 'No products found. Check your product IDs.';
          _loading = false;
        });
        return;
      }


      final sorted = response.productDetails
        ..sort((a, b) =>
            (_coinRewards[a.id] ?? 0).compareTo(_coinRewards[b.id] ?? 0));

      setState(() {
        _products = sorted;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _showMessage('Purchase pending...', Colors.orange);
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        _handleError(purchaseDetails.error!);
      } else if (purchaseDetails.status == PurchaseStatus.purchased) {
        _deliverCoins(purchaseDetails);
      }


      if (purchaseDetails.pendingCompletePurchase) {
        _iap.completePurchase(purchaseDetails);
      }
    }
  }

  void _deliverCoins(PurchaseDetails purchaseDetails) {
    final int coins = _coinRewards[purchaseDetails.productID] ?? 0;


    setState(() {
      _totalCoins += coins;
    });

    _showMessage('🎉 $coins coins added to your account!', Colors.green);
  }

  void _handleError(IAPError error) {
    _showMessage('Purchase failed: ${error.message}', Colors.red);
  }

  void _showMessage(String message, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _buyProduct(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: product,
    );

    try {

      await _iap.buyConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text(
          'Buy Coins',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.monetization_on,
                      color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '$_totalCoins',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (!_available) {
      return _buildError(_error ?? 'In-app purchases not available');
    }

    if (_loading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading coin packages...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return _buildError(_error!);
    }

    if (_products.isEmpty) {
      return const Center(child: Text('No coin packages available'));
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 16),

        // Header
        const Icon(Icons.monetization_on, color: Colors.amber, size: 72),
        const SizedBox(height: 16),
        const Text(
          'Get Coins',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Choose a coin package to get started',
          style: TextStyle(fontSize: 15, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 36),

        // Product Cards
        ..._products.map((product) => _buildCoinCard(product)),

        const SizedBox(height: 20),

        // Footer note
        const Text(
          'Purchases are non-refundable.\nCoins will be added instantly after purchase.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCoinCard(ProductDetails product) {
    final int coins = _coinRewards[product.id] ?? 0;
    final bool isBestValue = product.id == 'coinsmall1'; // Large pack
    final String displayName =
        _productNames[product.id] ?? product.title;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isBestValue
            ? Border.all(color: Colors.amber, width: 2.5)
            : Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: isBestValue
                ? Colors.amber.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Best value badge
            if (isBestValue) ...[
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '⭐ BEST VALUE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            Row(
              children: [
                // Coin icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isBestValue
                        ? Colors.amber.withValues(alpha: 0.15)
                        : Colors.blue.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.monetization_on,
                    color: isBestValue ? Colors.amber : Colors.blue,
                    size: 36,
                  ),
                ),
                const SizedBox(width: 16),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$coins Coins',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Price & Buy button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isBestValue ? Colors.amber.shade700 : Colors.green,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _buyProduct(product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isBestValue ? Colors.amber : Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: isBestValue ? 4 : 1,
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _loadProducts,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}