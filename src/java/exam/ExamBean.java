// Item Bean
package exam;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.ejb.*;
import javax.rmi.*;
import javax.naming.InitialContext;
import java.util.Properties;

import exam.*;
import examejb.*;
import java.io.FileInputStream;
import java.rmi.RemoteException;

public class ExamBean {

    private String ccode;
    Vector questions = new Vector();
    int qno;
    int TOTAL = 0;

    public int getQno() {
        return qno;
    }

    public int getTotal() {
        Connection con = null;;
        PreparedStatement ps = null;
        try {
            con = DBUtil.getConnection();
            ps = con.prepareStatement("select COUNT(qid) from questions where ccode = ?");
            ps.setString(1, ccode);
            ResultSet rs = ps.executeQuery();
            rs.next();
            TOTAL = rs.getInt(1);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return TOTAL;
    }

    public void setCcode(String ccode) {
        this.ccode = ccode;
    }
    public Question prevQuestion() {
        if (qno < TOTAL) {
            qno--;
            return (Question) questions.get(qno);
        } else {
            return null;
        }
    }
    public Question nextQuestion() {
        if (qno < TOTAL) {
            qno++;
            return (Question) questions.get(qno);
        } else {
            return null;
        }
    }
    public boolean isLastQuestion() {
        return (qno == TOTAL - 1);
    }

    public void setAnswer(String answer) {
        // get current question
        Question q = (Question) questions.get(qno);
        q.setAnswer(answer);
    }

    public void loadQuestions() {
        Vector qids = new Vector();
        Connection con = null;;
        PreparedStatement ps = null;
        qno = -1;
        try {

            // load questions for the given subject
            con = DBUtil.getConnection();
            ps = con.prepareStatement("select qid, question, ans1, ans2, ans3, ans4, cans from questions where ccode = ?");
            ps.setString(1, ccode);
            ResultSet rs = ps.executeQuery();

        // copy question ids into vector
            while (rs.next()) {
                qids.add(rs.getString(1));
            }

            rs.close();

            int noquestions = qids.size();
            System.out.print(noquestions + ".....................");

            Vector selqids = new Vector();
            // get 5 random numbers
            Random r = new Random();
            String qid;
            int pos;
            for (int i = 0; i < noquestions;) {
                pos = Math.abs(r.nextInt() % noquestions);
                // get question id from that position in vector
                qid = (String) qids.get(pos);
                if (!selqids.contains(qid)) {
                    selqids.add(qid);
                    i++;
                } // end of if
            } // end of for

	    // load questions with the given ids into vector
            rs = ps.executeQuery();

            questions.clear();

            Question q,p;

            while (rs.next()) {
                if (selqids.contains(rs.getString(1))) {
                    // get question details
                    int id = rs.getInt(1);
                    String question = rs.getString(2);
                    String ans1 = rs.getString(3);
                    String ans2 = rs.getString(4);
                    String ans3 = rs.getString(5);
                    String ans4 = rs.getString(6);
                    String cans = rs.getString(7);

                    q = new Question(id, question, ans1, ans2, ans3, ans4, cans);
                        p = new Question(id, question, ans1, ans2, ans3, ans4, cans);
                    questions.add(q);
                        questions.add(p);
                } // end of if

            }  // end of while
            rs.close();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            DBUtil.clean(con, ps);
        }

    }  // end of Bean

    public int getNoCorrectAnswers() {
        int cnt = 0;
        Question q;
        for (int i = 0; i < TOTAL; i++) {
            q = (Question) questions.get(i);
            if (q.isCorrect()) {
                cnt++;
            }
        }
        return cnt;
    }


    /* public void addExamRecord( String bcode, String rollno, int nomarks)  throws Exception
     {
     String userid;
     try
     {
     //Properties h = new Properties();
     // h.put(Context.INITIAL_CONTEXT_FACTORY, "weblogic.jndi.WLInitialContextFactory");
     //h.put(Context.PROVIDER_URL, "t3://localhost:7001");
     //h.load(new FileInputStream("jndi.properties"));
     //Context ctx =  new InitialContext(h);
     //Object home = ctx.lookup("ExamEJB3/remote");
     // ExamHome ehome = (ExamHome) home;
     // ExamRemote exam= ehome.create();
     //ExamRemote exam= new ExamRemote();
     // exam.add(bcode,rollno, nomarks);
     }
     catch(Exception ex)
     {
     System.out.println(ex.getMessage());
     throw ex;
     }
     } // end of addExamRecord()

     */
    public void addExamRecord(String bcode, String rollno, int marks) throws RemoteException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBUtil.getConnection();
            // get next exam id
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select max(examid)from exams");
            rs.next();
     //String examid = rs.getString(1);

            int examid = rs.getInt(1);
            System.out.println(examid + "*************************************");
            rs.close();
            st.close();
            //  insert new row
            ps = con.prepareStatement("insert into exams values(?,?,?,?,?)");
            java.sql.Date sysdate = new java.sql.Date(new java.util.Date().getTime());
            ps.setInt(1, examid + 1);
            ps.setString(2, bcode);
            ps.setString(3, rollno);
            ps.setInt(4, marks);
            ps.setDate(5, sysdate);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new RemoteException(ex.getMessage());
        } finally {
            try {
                ps.close();
                con.close();
            } catch (Exception ex) {
            }
        } // end of final
    } // end of ad

} // end of bean

