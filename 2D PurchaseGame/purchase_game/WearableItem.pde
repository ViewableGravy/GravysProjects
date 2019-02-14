
public abstract class WearableItem extends Item {
  
 private bodyPart bodypart;
 public WearableItem(float x, float y, String name, CurrencyPurse _cost, int _weight, categoryEnum _category, bodyPart _body, String _desc) {
    super(x, y, 5, name, _cost, _weight,_category, _desc);
    bodypart = _body;
 }
 
  public WearableItem(String name, CurrencyPurse _cost, categoryEnum _category, bodyPart _body, String _desc) {
    super(name, _cost, _category, _desc);
    bodypart = _body;
 }
 
 
 public bodyPart GetBodyPart() {
   return bodypart;
 }
 
 public abstract WearableItem CreateNewInstance();
 
}
