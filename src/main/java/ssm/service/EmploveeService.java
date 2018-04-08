package ssm.service;

import ssm.bean.Emplovee;
import ssm.bean.EmploveeExample;
import ssm.dao.EmploveeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmploveeService {

    @Autowired
    EmploveeMapper emploveeMapper;

    public List<Emplovee> getAll() {
        return emploveeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Emplovee emplovee) {
        emploveeMapper.insertSelective(emplovee);
    }

    public boolean checkUser(String empName) {
        EmploveeExample emploveeExample = new EmploveeExample();
        EmploveeExample.Criteria criteria = emploveeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = emploveeMapper.countByExample(emploveeExample);
        return count == 0;
    }

    public Emplovee getEmp(Integer id) {
        Emplovee emplovee = emploveeMapper.selectByPrimaryKey(id);
        return emplovee;
    }

    public void updateEmp(Emplovee emplovee) {
        emploveeMapper.updateByPrimaryKeySelective(emplovee);
    }

    public void deleteEmpById(Integer id) {
        emploveeMapper.deleteByPrimaryKey(id);
    }

    public void deleteEmpBatch(List<Integer> list) {
        EmploveeExample emploveeExample = new EmploveeExample();
        EmploveeExample.Criteria criteria = emploveeExample.createCriteria();
        criteria.andEmpIdIn(list);
        emploveeMapper.deleteByExample(emploveeExample);
    }
}
