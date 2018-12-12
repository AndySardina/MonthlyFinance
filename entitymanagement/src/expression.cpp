#include "db/querydsl/expression/expression.h"

class functor_t {
public:
    void operator ()(const Type& type, const QString& value) {
        switch (type) {
        case Type::COLUMN: case Type::NUMBER:
             m_res.append(value);
             break;
        case Type::STRING: case Type::DATE:
             m_res.append(QString("\'%1\'").arg(value));
             break;
        case Type::EQ:
            m_res.append(" = ");
            break;
        case Type::NEQ:
            m_res.append(" != ");
            break;
        case Type::GT:
            m_res.append(" > ");
            break;
        case Type::GOE:
            m_res.append(" >= ");
            break;
        case Type::LT:
            m_res.append(" < ");
            break;
        case Type::LOE:
            m_res.append(" <= ");
            break;
        case Type::AND:
            m_res.append(" AND ");
            break;
        case Type::OR:
            m_res.append(" OR ");
            break;
        case Type::BETWEEN:
            m_res.append(" BETWEEN ");
            break;
        case Type::LIKE:
            m_res.append(" LIKE ");
            break;
        }
    }

    QString result(){ return m_res; }
private:
    QString m_res;

};


Expression::Expression(const Type &opr, const QString &column, const QString &value, const Type &valueType)
{
    m_tree = stringtree_t::create_trio(opr, column, Type::COLUMN, value, valueType);
}

Expression &Expression::AND(const Expression& rigth)
{
    m_tree.merge(Type::AND, rigth.m_tree);

    return *this;
}

Expression &Expression::OR(const Expression& rigth)
{
    m_tree.merge(Type::OR, rigth.m_tree);
    return *this;
}


QString Expression::getQuery()
{
    functor_t func;
    m_tree.in_order_walk(func);

    return func.result();
}
