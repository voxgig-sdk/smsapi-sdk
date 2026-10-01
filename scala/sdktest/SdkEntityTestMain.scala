// Aggregating entry point for the generated per-entity SDK tests. Drives
// every <Entity>EntityTest / <Entity>DirectTest object through one shared
// SdkTestReport and exits non-zero on any failure.
// Run: scala-cli run . --main-class SdkEntityTestMain

object SdkEntityTestMain {

  def main(args: Array[String]): Unit = {
    val rep = new SdkTestReport()

    AvailableEntityTest.run(rep)
    AvailableDirectTest.run(rep)
    BlacklistEntityTest.run(rep)
    BlacklistDirectTest.run(rep)
    CallbackEntityTest.run(rep)
    CallbackDirectTest.run(rep)
    ContactEntityTest.run(rep)
    ContactDirectTest.run(rep)
    ContactsFieldEntityTest.run(rep)
    ContactsFieldDirectTest.run(rep)
    ContactsFieldOptionEntityTest.run(rep)
    ContactsFieldOptionDirectTest.run(rep)
    ContactsgroupEntityTest.run(rep)
    ContactsgroupDirectTest.run(rep)
    ContactstrashEntityTest.run(rep)
    FieldAvailableEntityTest.run(rep)
    FieldAvailableDirectTest.run(rep)
    GroupEntityTest.run(rep)
    GroupDirectTest.run(rep)
    MfaCodeEntityTest.run(rep)
    OptOutEntityTest.run(rep)
    OptOutDirectTest.run(rep)
    OptOutSettingEntityTest.run(rep)
    OptOutSettingDirectTest.run(rep)
    PermissionEntityTest.run(rep)
    PermissionDirectTest.run(rep)
    PingEntityTest.run(rep)
    PingDirectTest.run(rep)
    ProfileEntityTest.run(rep)
    ProfileDirectTest.run(rep)
    RcsEntityTest.run(rep)
    RcsDirectTest.run(rep)
    SendernameEntityTest.run(rep)
    SendernameDirectTest.run(rep)
    SendernameStatementEntityTest.run(rep)
    SendernameStatementDirectTest.run(rep)
    SentRcsMessageEntityTest.run(rep)
    ShipmentCountryVolumeEntityTest.run(rep)
    ShipmentCountryVolumeDirectTest.run(rep)
    ShortUrlEntityTest.run(rep)
    ShortUrlDirectTest.run(rep)
    SmsdoEntityTest.run(rep)
    SmssendernameEntityTest.run(rep)
    SmstemplateEntityTest.run(rep)
    SubuserEntityTest.run(rep)
    SubuserDirectTest.run(rep)
    TemplateEntityTest.run(rep)
    TemplateDirectTest.run(rep)
    UserRcsSenderCollectionEntityTest.run(rep)
    UserRcsSenderCollectionDirectTest.run(rep)

    ReadmeExamplesTest.run(rep)

    rep.finish("ENTITY")
  }
}
