package vo;


public class CommentVO {
	private int NID;
	private int commnet_num = 0;
	private String writer;
	private String date;
	private String content;
	public int getNID() {
		return NID;
	}
	public void setNID(int nID) {
		NID = nID;
	}
	public int getCommnet_num() {
		return commnet_num;
	}
	public void setCommnet_num(int commnet_num) {
		this.commnet_num += commnet_num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String string) {
		this.date = string;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
