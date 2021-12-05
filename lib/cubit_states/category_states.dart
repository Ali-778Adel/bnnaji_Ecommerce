abstract class Category_States {}

class Category_IntialState extends Category_States{}
class CategoryItemStateState extends Category_States{}

class getCategoryDataFromServerLoadingState extends Category_States{}
class getCategoryDataFromServerState extends Category_States{}
class getCategoryDataFromServerFailureState extends Category_States{}
class CircularprogressState extends Category_States{}


class getProductsDataFromServerState extends Category_States{}
class OnCategoryItemTapped extends Category_States{}



//databaseSates
class CreateDatabaseState extends Category_States{}
class OpenDatabaseState extends Category_States{}
class InsertItoDatabaseState extends Category_States{}
class GetDataFroDatabaseState extends Category_States{}
