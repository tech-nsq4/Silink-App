part of 'profile_completion_cubit.dart';

class ProfileCompletionState extends Equatable {
  final bool channelsLoading;
  final List<ChannelModel> channels;
  final String? channelsError;

  final bool linksLoading;
  final List<LinkModel> links;
  final String? linksError;

  final bool catalogLoading;
  final CatalogModel? catalog;
  final String? catalogError;
  final bool isSavingCatalogItem;
  final String? savingCatalogItemId;

  final bool arrangementLoading;
  final List<ArrangementSectionModel> arrangement;
  final String? arrangementError;

  final bool templatesLoading;
  final TemplateSettings? templates;
  final String? templatesError;

  final bool appearanceLoading;
  final AppearanceModel? appearance;
  final String? appearanceError;

  final bool isSavingStep;

  const ProfileCompletionState({
    this.channelsLoading = false,
    this.channels = const [],
    this.channelsError,
    this.linksLoading = false,
    this.links = const [],
    this.linksError,
    this.catalogLoading = false,
    this.catalog,
    this.catalogError,
    this.isSavingCatalogItem = false,
    this.savingCatalogItemId,
    this.arrangementLoading = false,
    this.arrangement = const [],
    this.arrangementError,
    this.templatesLoading = false,
    this.templates,
    this.templatesError,
    this.appearanceLoading = false,
    this.appearance,
    this.appearanceError,
    this.isSavingStep = false,
  });

  bool get channelsLoaded => channels.isNotEmpty || channelsError != null;
  bool get linksLoaded => links.isNotEmpty || linksError != null;
  bool get catalogLoaded => catalog != null || catalogError != null;
  bool get arrangementLoaded =>
      arrangement.isNotEmpty || arrangementError != null;
  bool get templatesLoaded => templates != null || templatesError != null;
  bool get appearanceLoaded => appearance != null || appearanceError != null;

  ProfileCompletionState copyWith({
    bool? channelsLoading,
    List<ChannelModel>? channels,
    String? channelsError,
    bool clearChannelsError = false,
    bool? linksLoading,
    List<LinkModel>? links,
    String? linksError,
    bool clearLinksError = false,
    bool? catalogLoading,
    CatalogModel? catalog,
    String? catalogError,
    bool clearCatalogError = false,
    bool? isSavingCatalogItem,
    String? savingCatalogItemId,
    bool clearSavingCatalogItemId = false,
    bool? arrangementLoading,
    List<ArrangementSectionModel>? arrangement,
    String? arrangementError,
    bool clearArrangementError = false,
    bool? templatesLoading,
    TemplateSettings? templates,
    String? templatesError,
    bool clearTemplatesError = false,
    bool? appearanceLoading,
    AppearanceModel? appearance,
    String? appearanceError,
    bool clearAppearanceError = false,
    bool? isSavingStep,
  }) {
    return ProfileCompletionState(
      channelsLoading: channelsLoading ?? this.channelsLoading,
      channels: channels ?? this.channels,
      channelsError:
          clearChannelsError ? null : (channelsError ?? this.channelsError),
      linksLoading: linksLoading ?? this.linksLoading,
      links: links ?? this.links,
      linksError: clearLinksError ? null : (linksError ?? this.linksError),
      catalogLoading: catalogLoading ?? this.catalogLoading,
      catalog: catalog ?? this.catalog,
      catalogError:
          clearCatalogError ? null : (catalogError ?? this.catalogError),
      isSavingCatalogItem: isSavingCatalogItem ?? this.isSavingCatalogItem,
      savingCatalogItemId: clearSavingCatalogItemId
          ? null
          : (savingCatalogItemId ?? this.savingCatalogItemId),
      arrangementLoading: arrangementLoading ?? this.arrangementLoading,
      arrangement: arrangement ?? this.arrangement,
      arrangementError: clearArrangementError
          ? null
          : (arrangementError ?? this.arrangementError),
      templatesLoading: templatesLoading ?? this.templatesLoading,
      templates: templates ?? this.templates,
      templatesError:
          clearTemplatesError ? null : (templatesError ?? this.templatesError),
      appearanceLoading: appearanceLoading ?? this.appearanceLoading,
      appearance: appearance ?? this.appearance,
      appearanceError: clearAppearanceError
          ? null
          : (appearanceError ?? this.appearanceError),
      isSavingStep: isSavingStep ?? this.isSavingStep,
    );
  }

  @override
  List<Object?> get props => [
        channelsLoading,
        channels,
        channelsError,
        linksLoading,
        links,
        linksError,
        catalogLoading,
        catalog,
        catalogError,
        isSavingCatalogItem,
        savingCatalogItemId,
        arrangementLoading,
        arrangement,
        arrangementError,
        templatesLoading,
        templates,
        templatesError,
        appearanceLoading,
        appearance,
        appearanceError,
        isSavingStep,
      ];
}
