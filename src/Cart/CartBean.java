package Cart;

public class CartBean {

	public int getCart_id() {
		return cart_id;
	}
	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}
	public String getBuyer() {
		return buyer;
	}
	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	public int getFood_id() {
		return food_id;
	}
	public void setFood_id(int food_id) {
		this.food_id = food_id;
	}
	public String getFood_name() {
		return food_name;
	}
	public void setFood_name(String food_name) {
		this.food_name = food_name;
	}
	public int getBuy_price() {
		return buy_price;
	}
	public void setBuy_price(int buy_price) {
		this.buy_price = buy_price;
	}
	public int getBuy_count() {
		return buy_count;
	}
	public void setBuy_count(int buy_count) {
		this.buy_count = buy_count;
	}
	public String getFood_image() {
		return food_image;
	}
	public void setFood_image(String food_image) {
		this.food_image = food_image;
	}
	private int cart_id; //?₯λ°κ΅¬?? ??΄?
	private String buyer; //κ΅¬λ§€?
	private int food_id; //κ΅¬λ§€? μ±μ ??΄?
	private String food_name;//κ΅¬λ§€? μ±λͺ
	private int  buy_price;//?λ§€κ?
	private int buy_count; //?λ§€μ?
	private String food_image;//μ±μ΄λ―Έμ?
	
	
	
	
}
