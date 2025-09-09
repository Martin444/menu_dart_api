# Get Orders by Business Owner Endpoint

This document describes the new `orders/byBusinessOwner/{businessOwnerId}` endpoint that has been added to the menu_dart_api package.

## Overview

The endpoint allows you to retrieve all orders associated with a specific business owner. It supports both anonymous ID tracking and JWT token authorization.

## Endpoint Details

- **URL**: `GET /orders/byBusinessOwner/{businessOwnerId}`
- **Method**: GET
- **Authentication**: Bearer Token (JWT)
- **Headers**: 
  - `Authorization: Bearer {jwt_token}`
  - `X-anonymous-id: {anonymous_id}` (automatically included)

## Implementation

### Files Modified/Created

1. **Repository**: `lib/by_feature/orders/repository/order_repository.dart`
   - Added `getOrdersByBusinessOwner(String businessOwnerId)` method

2. **Provider**: `lib/by_feature/orders/provider/order_provider.dart`
   - Implemented the HTTP call to the API endpoint
   - Automatic handling of anonymous ID and authorization headers

3. **Use Case**: `lib/by_feature/orders/usescase/order_usescase.dart`
   - Added `GetOrdersByBusinessOwnerUseCase` class

## Usage Example

```dart
import 'package:menu_dart_api/menu_com_api.dart';

void main() async {
  // 1. Initialize the API with your base URL
  API.getInstance('http://localhost:3001');
  
  // 2. Set the access token (Bearer token)
  API.setAccessToken('your-jwt-token-here');
  
  try {
    // 3. Create instance of the use case
    final getOrdersByBusinessOwnerUseCase = GetOrdersByBusinessOwnerUseCase();
    
    // 4. Call the endpoint with the business owner ID
    final String businessOwnerId = '12dd8541-48f3-4639-be7e-5029bd338f88';
    final List<Order> orders = await getOrdersByBusinessOwnerUseCase.call(businessOwnerId);
    
    // 5. Use the results
    debugPrint('Found ${orders.length} orders for business owner $businessOwnerId');
    
    for (final order in orders) {
      debugPrint('Order ID: ${order.id}');
      debugPrint('Customer Email: ${order.customerEmail}');
      debugPrint('Total: ${order.total}');
      debugPrint('Status: ${order.status}');
      debugPrint('Created At: ${order.createdAt}');
      debugPrint('---');
    }
    
  } catch (e) {
    debugPrint('Error getting orders by business owner: $e');
  }
}
```

## CURL Example

The equivalent CURL command for this endpoint would be:

```bash
curl --location 'http://localhost:3001/orders/byBusinessOwner/12dd8541-48f3-4639-be7e-5029bd338f88' \
--header 'X-anonymous-id: 10499844-1b56-490f-a001-0c34fe24ee49' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImRpbm5pbmciLCJzdWIiOiIxMmRkODU0MS00OGYzLTQ2MzktYmU3ZS01MDI5YmQzMzhmODgiLCJpYXQiOjE3NTU0MDQ4MTMsImV4cCI6MTc1NTQ5MTIxM30.-cxaeuFFSoISjV_NwivHC4u6exHfyliSB-AYYU-oPKI'
```

## Response Format

The endpoint returns a JSON array of Order objects. Each Order object contains:

```json
[
  {
    "id": "string",
    "customerEmail": "string",
    "customerPhone": "string",
    "createdBy": "string",
    "ownerId": "string",
    "operationID": "string",
    "paymentUrl": "string",
    "items": [...],
    "total": number,
    "status": "string",
    "createdAt": "2024-01-01T00:00:00.000Z",
    "updatedAt": "2024-01-01T00:00:00.000Z"
  }
]
```

## Error Handling

The implementation includes proper error handling:

- HTTP status codes other than 200 will throw an exception
- Network errors are properly propagated
- Invalid JSON responses are handled gracefully

## Features

- ✅ Automatic Anonymous ID header inclusion
- ✅ JWT Bearer token authorization
- ✅ Type-safe response parsing to `Order` objects
- ✅ Proper error handling
- ✅ Consistent with existing API patterns
- ✅ Exported in the main `menu_com_api.dart` file

## Testing

You can test the implementation by running the example:

```bash
dart run example/get_orders_by_business_owner_example.dart
```

This will show you how to use the new endpoint and verify that it compiles correctly.
