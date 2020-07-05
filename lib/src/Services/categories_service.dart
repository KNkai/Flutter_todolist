import 'package:todolist_sqflite/src/Models/category_model.dart';
import 'package:todolist_sqflite/src/repository/cate_repository.dart';

class CategoriesService{

  CateRepository _cateRepository;

  CategoriesService(){
    _cateRepository = CateRepository();
  }

  saveCategory(Category category) async {
    return await _cateRepository.save('categories', category.categoryMap());
  }

  getCategory()async{
    return await _cateRepository.getAll('categories');
  }

  deleteCategory(int id)async{
    return await _cateRepository.delete('categories', id);
  }

  updateCategory(Category category)async{
    return await _cateRepository.update('categories', category.categoryMap(), category.id);
  }

  getACategory(int id)async{
    return await _cateRepository.getACategory('categories', id);
  }
}