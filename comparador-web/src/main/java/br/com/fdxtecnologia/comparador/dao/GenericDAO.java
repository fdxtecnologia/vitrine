/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.dao;

import br.com.fdxtecnologia.comparador.factory.HibernateFactory;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Andre
 */
public class GenericDAO<T> {

    public void save(T obj) {
        Session s = HibernateFactory.getSession();
        Transaction tx = s.beginTransaction();
        try {
            s.save(obj);
            tx.commit();
        } catch (HibernateException e) {
            tx.rollback();
            e.printStackTrace();
        } finally {
            closeSession(s);
        }
    }

    public void update(T obj) {
        Session s = HibernateFactory.getSession();
        Transaction tx = s.beginTransaction();
        try {
            s.update(obj);
            tx.commit();
        } catch (HibernateException e) {
            tx.rollback();
            e.printStackTrace();
        } finally {
            closeSession(s);
        }
    }

    public void delete(T obj) {
        Session s = HibernateFactory.getSession();
        Transaction tx = s.beginTransaction();
        try {
            s.delete(obj);
            tx.commit();
        } catch (HibernateException e) {
            tx.rollback();
            e.printStackTrace();
        } finally {
            closeSession(s);
        }
    }

    protected void closeSession(Session s) {
        try {
            s.close();
        } catch (HibernateException e) {
            e.printStackTrace();
        }
    }

    public T loadById(T obj) {
        try {
            Session s = HibernateFactory.getSession();
            Method m = obj.getClass().getDeclaredMethod("getId");
            Long id;
            id = (Long) m.invoke(obj);
            if (id == null) {
                return null;
            }
            try {
                String query = "from " + obj.getClass().getSimpleName() + " where id = " + id;
                Query q = s.createQuery(query);
                return (T) q.uniqueResult();
            } catch (HibernateException e) {
                e.printStackTrace();
            } finally {
                closeSession(s);
            }
        } catch (NoSuchMethodException ex) {
            ex.printStackTrace();
        } catch (InvocationTargetException ex) {
            ex.printStackTrace();
        } catch (IllegalAccessException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<T> listAll(Class c) {
        Session s = HibernateFactory.getSession();
        try {
            Query q = s.createQuery("from " + c.getSimpleName());
            return (List<T>) q.list();
        } catch (HibernateException e) {
            e.printStackTrace();
        } finally {
            closeSession(s);
        }
        return null;
    }
}
