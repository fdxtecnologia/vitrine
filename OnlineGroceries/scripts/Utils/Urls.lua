BASE_URL = "http://192.168.0.100:8080/vitrine-services/";

--- Products ---
LIST_PRODS = BASE_URL.."products/listProducts"; -- Lista produtos com limite //params(int marketId, int page, int limit)--
LIST_ALL_PRODS_MK = BASE_URL.."products/listMarketProducts"; --Lista todos produtos de um supermecado //params(int marketId)--


--- Customer ---
LOGIN_FACEBOOK = BASE_URL.."customers/loginFB"; --login com as informações do facebook

--- Order ---
PLACE_ORDER = BASE_URL.."order/placeOrder"; -- Salvar pedido e efetuar pagamento //params (Order order)
