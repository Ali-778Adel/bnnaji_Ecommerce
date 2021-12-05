abstract class Cart_States {}

class Cart_IntialState extends Cart_States{}

class ShowCartList extends Cart_States{}


class onCartIconTappedState extends Cart_States{}
class onGestureDetectorTapedState extends Cart_States{}
class addCartListState extends Cart_States{}
class removeCartListState extends Cart_States{}


class CreateCartDatabase extends Cart_States{}
class OpenCartDatabase extends Cart_States{}
class InsertIntoCartDatabase extends Cart_States{}
class GetDataFromCartDatabase extends Cart_States{}
class UpdataCartDatabase extends Cart_States{}
class DeleteFromCartDatbase extends Cart_States{}