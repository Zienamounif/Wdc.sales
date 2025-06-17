class AppLink{

  static const String server ="http://wdcgateway.runasp.net";

   static const String login ="$server/users/login";
   static const String register ="$server/users/register";
   static const String products ="$server/products/get-products";
   static const String addOrder ="$server/orders/create";
   static const String getOrders ="$server/orders/all";
   static  String deleteOrder(String orderId)=>"$server/orders/$orderId/cancel";

   static const String payments="$server/wallet/reduce-balance";
   

}