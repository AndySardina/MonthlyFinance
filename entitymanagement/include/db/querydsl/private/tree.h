#ifndef TREE_H
#define TREE_H

#include <memory>

#include <QString>

enum class Type : char {
    VALUE = 0,
    AND   = 1,
    OR    = 2,
    NOT   = 3
};

template<typename T>
struct bnode
{
    using bnode_ptr = std::shared_ptr<bnode<T>>;

    bnode(Type type, const T& value) :
        m_type(type), m_value(value)
    {}

    Type m_type;
    T m_value;

    bnode_ptr m_right = Q_NULLPTR;
    bnode_ptr m_left = Q_NULLPTR;
};


template<typename T, typename Func>
class btree
{
public:
     using bnode_ptr = std::shared_ptr<bnode<T>>;

    btree() = default;

    void in_order_walk(const Func& functor){
         in_order_walk_helper(m_root, functor);
    }

    void create_triplet(bnode_ptr root, bnode_ptr left, bnode_ptr right){
        if( m_root != nullptr ){
            throw std::runtime_error("The tree is already initialized.");
        }

        m_root = root;
        m_root->m_right = right;
        m_root->m_left = left;
    }

private:
    void in_order_walk_helper(bnode_ptr node, const Func& functor){
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
