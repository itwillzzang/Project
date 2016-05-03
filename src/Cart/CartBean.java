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
	private int cart_id; //?¥ë°”êµ¬?‹ˆ?˜ ?•„?´?””
	private String buyer; //êµ¬ë§¤?
	private int food_id; //êµ¬ë§¤?œ ì±…ì˜ ?•„?´?””
	private String food_name;//êµ¬ë§¤?œ ì±…ëª…
	private int  buy_price;//?Œë§¤ê?
	private int buy_count; //?Œë§¤ìˆ˜?Ÿ‰
	private String food_image;//ì±…ì´ë¯¸ì?
	
	
	
	
}
