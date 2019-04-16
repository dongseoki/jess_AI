package financial_expert_consultation;
import javax.swing.*;
import java.awt.event.*;
import java.awt.*;
import java.util.*;
import jess.*;
import jess.awt.TextAreaWriter;

public class InvCon extends JFrame {
	
	TextArea t;
	JButton b1, b2 ;
	JTextField  tf1, tf2, tf3 ;
	JLabel jl1, jl2, jl3 ;
	String fs;
	Rete engine ;
	
	InvCon() {
		setTitle("���� ���");
		setLayout(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		t = new TextArea(10, 40);
		JScrollPane js = new JScrollPane(t);
		js.setSize(400, 200);
		js.setLocation(20, 15);
		add(js);
		MyActionListener ml 
		                = new MyActionListener();
		b1 = new JButton("������");
		b1.addActionListener(ml);
		b1.setSize(180, 30);
		b1.setLocation(450, 30);
		add(b1);
		b2 = new JButton("�ʱ�ȭ");
		b2.addActionListener(ml);
		b2.setSize(180, 30);
		b2.setLocation(630, 30);
		add(b2);
		jl1 = new JLabel("���ҵ�");
		tf1 = new JTextField(20);
		jl1.setSize(100, 30);
		tf1.setSize(260, 30);	
		jl1.setLocation(450, 80);
		
		
		
	    tf1.setLocation(550, 80);
	    add(jl1);
	     add(tf1);
	     jl2= new JLabel("�ξ簡��");
	     tf2 = new JTextField(20);
	     jl2.setSize(100, 30);
	     tf2.setSize(260, 30);	
	     jl2.setLocation(450, 120);
	     tf2.setLocation(550, 120);
	     add(jl2);
	     add(tf2);
	     jl3= new JLabel("�����");
	     tf3 = new JTextField(20);
	     jl3.setSize(100, 30);
	     tf3.setSize(260, 30);	
	     jl3.setLocation(450, 160);
	     tf3.setLocation(550, 160);
	     add(jl3);
	     add(tf3);
	     setSize(850,270);
	     setVisible(true);
	}
	private class MyActionListener implements ActionListener {
	     public void actionPerformed(ActionEvent e) {
		JButton b = (JButton)e.getSource();
		if(b == b1) {
			t.append("\n \n *** ��� �Ƿ����� ��Ȳ *** \n \n" );
			t.append("������ : " +  "$"+ tf1.getText() + "\n");
			t.append("�ξ簡�� : " + tf2.getText() + "��" + "\n");
			t.append("����� : " + "$" + tf3.getText() + "\n");
	                               fs = "";
			fs = fs + "\n(assert (earnings " +  tf1.getText() + " steady))";
			fs = fs + "\n(assert (dependents " +  tf2.getText() + "))";
			fs = fs + "\n(assert (amount_saved " +  tf3.getText() + "))";
			fs = fs + "\n (run)";
			t.append("\n \n *** ��� ��� *** \n \n" );		
			btnRunActionPerformed(e);
		} else if (b == b2){
			t.setText(""); tf1.setText(""); tf2.setText("");
			tf3.setText(""); fs = "";} 
	    }
	}
	private void btnRunActionPerformed(ActionEvent e) {
	      try {
		ReadJessFile readJessFile = new  					       
	                     ReadJessFile("C:\\Users\\like_\\Documents\\GitHub\\jess_AI\\financial_expert.clp");
		String strTemp = readJessFile.getJessFileContent();		
		if (strTemp.substring(0, 1).equals("1")) {  // 0��° ù ���ڿ� 
			this.engine = new Rete();
			TextAreaWriter taw = new TextAreaWriter(t);
			engine.addOutputRouter("t", taw);
			strTemp = strTemp + fs;
			this.engine.executeCommand(strTemp.substring(1)); 
	                                                            // 1��°���� ��ü ���ڿ�, �ڹٿ��� Jess ���� 
		  }		
	              } catch (JessException ex) {
	                                  //	this.taTrace.append(ex.toString() + "\n");
			}	
	}
	public static void main(String [] args) {
			new InvCon();
		}
}