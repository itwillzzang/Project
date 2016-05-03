package shop;
import java.sql.Timestamp;




public class ShopBean {



		private int food_id; //음식의 등록번호
		private String food_kind; //음식의 맛
		private String food_name; //음식의 이름
		private int food_price; //음식의 가격
		private int food_count; //음식 재고수량
		private String food_image; //음식의 이미지명
		private String food_content; //음식의내용
		private Timestamp reg_date; //음식의 등록날짜
		
		public int getFood_id() {
			return food_id;
		}
		public void setFood_id(int food_id) {
			this.food_id = food_id;
		}
		public String getFood_kind() {
			return food_kind;
		}
		public void setFood_kind(String food_kind) {
			this.food_kind = food_kind;
		}
		public String getFood_name() {
			return food_name;
		}
		public void setFood_name(String food_name) {
			this.food_name = food_name;
		}
		public int getFood_price() {
			return food_price;
		}
		public void setFood_price(int food_price) {
			this.food_price = food_price;
		}
		public int getFood_count() {
			return food_count;
		}
		public void setFood_count(int food_count) {
			this.food_count = food_count;
		}
		public String getFood_image() {
			return food_image;
		}
		public void setFood_image(String food_image) {
			this.food_image = food_image;
		}
		public String getFood_content() {
			return food_content;
		}
		public void setFood_content(String food_content) {
			this.food_content = food_content;
		}
		public Timestamp getReg_date() {
			return reg_date;
		}
		public void setReg_date(Timestamp reg_date) {
			this.reg_date = reg_date;
		}
		
	
	
}

