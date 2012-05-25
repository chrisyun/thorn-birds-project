如下几点约定
1、mapper中
	Base_Column_List：列集合
	Where_Clause：where条件，输入为hashmap
	selectByPK:根据主键查找，返回对象，输入为主键
	select：一般查询，返回list，输入为hashmap
	selectPage：分页查询，返回list，输入为hashmap
	selectCount：查询数量，一般是分页使用，返回long，输入为hashmap
	insert：新增，输入为实体对象
	update：更新，输入为实体对象
	deleteByPKs：批量删除，输入为主键的ID集合，list对象
	BaseResultMap：map与实体的映射
2、package中：
	开头：org.cy.thorn
	next：module名
	dao：数据库操作类	接口（I+...+DAO）	实现（...+DAOImpl）
	entity：实体类
	mapper：mybatis XML
	controller：web action
3、是为"0"，否为"1"
4、所有的数据库时间除非少数情况，一般都是YYYY-MM-DD
5、UID\ACCOUNT统一在数据库中存放大写