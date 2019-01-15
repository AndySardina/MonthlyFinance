#ifndef QML_ACTION_TYPES_H
#define QML_ACTION_TYPES_H

enum class ActionType
{
    ShowFileDialog,
    SelectFile,
    UploadFtp,
    UploadFtpStarted,
    UploadFtpProcess,
    UploadFtpFinished,

    // currency crud actions
    CreateCurrency,
    ReadCurrency,
    UpdateCurrency,
    ListCurrency,
    RemoveCurrency,
    RemoveBulkCurrency,
    SaveCurrencyFinished, // this action from response
    AskRequesNewCurency,
    AskRequesUpdateCurency,
};

#endif
