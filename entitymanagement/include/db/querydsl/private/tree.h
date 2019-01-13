#ifndef TREE_H
#define TREE_H

#include <memory>

#include <QString>

#include "db/querydsl/constants.h"

template<typename T>
class ENTITYMANAGEMENTSHARED_EXPORT btree
{    
private:
    struct bnode
    {

        bnode(Type type, const T& value) :
            m_type(type), m_value(value)
        {}

        Type m_type;
        T m_value;

        std::shared_ptr<bnode> m_right = Q_NULLPTR;
        std::shared_ptr<bnode> m_left = Q_NULLPTR;
    };



public:
    using bnode_ptr = std::shared_ptr<bnode>;

    btree() = default;

    template<typename Func>
    void in_order_walk(Func& functor){
         in_order_walk_helper(m_root, functor);
    }

    static btree<T> create_trio(const Type& rootType, const T& left_value, const Type& left_type, const T& right_value, const Type& right_type){
        btree<T> tree;
        tree.m_root = std::make_shared<bnode>(rootType, "");

        tree.m_root->m_left = std::make_shared<bnode>(left_type, left_value);
        tree.m_root->m_right = std::make_shared<bnode>(right_type, right_value);

        return tree;
    }

    void merge(const Type& rootType, const btree<T>& rigth){
        bnode_ptr tmp = m_root;

        m_root = std::make_shared<bnode>(rootType, "");
        m_root->m_left = tmp;
        m_root->m_right = rigth.m_root;
    }

private:
    template<typename Func>
    void in_order_walk_helper(bnode_ptr node, Func& functor){
        if( node->m_left != Q_NULLPTR )
            in_order_walk_helper(node->m_left, functor);

        functor(node->m_type, node->m_value);

        if( node->m_right != Q_NULLPTR )
            in_order_walk_helper(node->m_right, functor);
    }

private:
     bnode_ptr m_root = Q_NULLPTR;

};

#endif // TREE_H
