// Slider Model class and fucntions for obtaining and setting onboarding data
class SliderModel{
  
  String imagePath;
  String description;
  String explanation;

  SliderModel({this.imagePath, this.description, this.explanation});
  
  // Setters
  void setImagePath(String getImagePath){
    imagePath = getImagePath;
  }
  void setDescription(String des){
    description = des;
  }

  void setExplanation(String exp){
    explanation = exp;
  }


  //Getters
  String getExplanation(){
    return explanation;
  }
  String getImagePath(){
    return imagePath;
  }
  String getDescription(){
    return description;
  }

}


List<SliderModel> getSlides(){
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  sliderModel.setImagePath("assets/Onboarding1.png");
  sliderModel.setDescription("Welcome to \n MyTeams");
  sliderModel.setExplanation("     Video call your friends, \nchat and share with MyTeams");
  slides.add(sliderModel);
  sliderModel = new SliderModel();

  sliderModel.setImagePath("assets/Onboarding2.png");
  sliderModel.setDescription("Video Calling");
  sliderModel.setExplanation("    MyTeams lets you video call\n         your friends and talk!");
  slides.add(sliderModel);
  sliderModel = new SliderModel();

  sliderModel.setImagePath("assets/Onboarding3.png");
  sliderModel.setDescription("Live Chat");
  sliderModel.setExplanation("      MyTeams lets you chat and \n share your ideas while on video call!");
  slides.add(sliderModel);
  sliderModel = new SliderModel();

  return slides;



}