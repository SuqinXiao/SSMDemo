package ssm.test;

import ssm.bean.Emplovee;
import ssm.dao.DepartmentMapper;
import ssm.dao.EmploveeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.UUID;


public class MapperTest {

    @Test
    public void testCRUD() {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        DepartmentMapper departmentMapper = (DepartmentMapper) context.getBean("departmentMapper");
//        EmploveeMapper emploveeMapper = (EmploveeMapper) context.getBean("emploveeMapper");

//        departmentMapper.insertSelective(new Department(null,"测试部"));
//        departmentMapper.insertSelective(new Department(null,"开发部"));

//        emploveeMapper.insertSelective(new Emplovee(null,"Jerry", "M","791677420@qq.com",1));

        SqlSession sqlSession = (SqlSession) context.getBean("sqlSession");
        EmploveeMapper emploveeMapper = sqlSession.getMapper(EmploveeMapper.class);
        for (int i = 0; i<100; i++){
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            emploveeMapper.insertSelective(new Emplovee(null,uid,"M",uid+"@qq.com",1));
        }

    }
}
