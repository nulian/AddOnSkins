local AS = unpack(AddOnSkins)

function AS:Blizzard_TradeWindow(event, addon)
	AS:SkinFrame(TradeFrame, nil, nil, true)
	AS:StripTextures(TradeFrameInset)
	AS:StripTextures(TradeRecipientMoneyBg)
	AS:SkinFrame(TradeRecipientMoneyInset)
	AS:SkinButton(TradeFrameTradeButton, true)
	AS:SkinButton(TradeFrameCancelButton, true)
	AS:SkinCloseButton(TradeFrameCloseButton)

	AS:SkinEditBox(TradePlayerInputMoneyFrameGold)
	AS:SkinEditBox(TradePlayerInputMoneyFrameSilver)
	AS:SkinEditBox(TradePlayerInputMoneyFrameCopper)

	AS:StripTextures(TradePlayerInputMoneyInset)
	TradePlayerInputMoneyFrame:SetPoint('TOPLEFT', 8, -59)
	TradePlayerItem1:SetPoint('TOPLEFT', 8, -89)

	for _, Inset in pairs({ TradePlayerItemsInset, TradeRecipientItemsInset, TradePlayerEnchantInset, TradeRecipientEnchantInset }) do
		AS:SkinFrame(Inset)
	end

	for _, Highlight in pairs({ TradeHighlightPlayer, TradeHighlightRecipient, TradeHighlightPlayerEnchant, TradeHighlightRecipientEnchant }) do
		Highlight:StripTextures()
	end

	for _, Frame in pairs({"TradePlayerItem", "TradeRecipientItem"}) do
		for i = 1, 7 do
			local ItemBackground = _G[Frame..i]
			local ItemButton = _G[Frame..i.."ItemButton"]

			AS:StripTextures(ItemBackground)
			AS:SkinFrame(ItemButton)
			AS:StyleButton(ItemButton)

			AS:SkinTexture(ItemButton.icon)
			ItemButton.icon:SetInside()
			AS:CreateBackdrop(ItemButton)
			ItemButton.Backdrop:SetBackdropColor(0, 0, 0, 0)
			ItemButton.Backdrop:SetPoint("TOPLEFT", ItemButton, "TOPRIGHT", 4, 0)
			ItemButton.Backdrop:SetPoint("BOTTOMRIGHT", _G[Frame..i.."NameFrame"], "BOTTOMRIGHT", -1, 14)
		end
	end

	hooksecurefunc('TradeFrame_SetAcceptState', function(playerState, targetState)
		if ( playerState == 1 ) then
			TradePlayerItemsInset:SetBackdropBorderColor(0, 1, 0)
			TradePlayerEnchantInset:SetBackdropBorderColor(0, 1, 0)
		else
			TradePlayerItemsInset:SetBackdropBorderColor(unpack(AS.BorderColor))
			TradePlayerEnchantInset:SetBackdropBorderColor(unpack(AS.BorderColor))
		end
		if ( targetState == 1 ) then
			TradeRecipientItemsInset:SetBackdropBorderColor(0, 1, 0)
			TradeRecipientEnchantInset:SetBackdropBorderColor(0, 1, 0)
			TradeRecipientMoneyInset:SetBackdropBorderColor(0, 1, 0)
		else
			TradeRecipientItemsInset:SetBackdropBorderColor(unpack(AS.BorderColor))
			TradeRecipientEnchantInset:SetBackdropBorderColor(unpack(AS.BorderColor))
			TradeRecipientMoneyInset:SetBackdropBorderColor(unpack(AS.BorderColor))
		end
	end)

	hooksecurefunc('TradeFrame_UpdatePlayerItem', function(id)
		local tradeItem = _G["TradePlayerItem"..id.."ItemButton"]
		tradeItem:SetBackdropBorderColor(unpack(AS.BorderColor))
		local Link = GetTradePlayerItemLink(id)
		if Link then
			local Quality = select(3, GetItemInfo(Link))
			if Quality and Quality > 1 then
				tradeItem:SetBackdropBorderColor(GetItemQualityColor(Quality))
			end
		end
	end)

	hooksecurefunc('TradeFrame_UpdateTargetItem', function(id)
		local tradeItem = _G["TradeRecipientItem"..id.."ItemButton"]
		tradeItem:SetBackdropBorderColor(unpack(AS.BorderColor))
		local Link = GetTradeTargetItemLink(id)
		if Link then
			local Quality = select(3, GetItemInfo(Link))
			if Quality and Quality > 1 then
				tradeItem:SetBackdropBorderColor(GetItemQualityColor(Quality))
			end
		end
	end)
end

AS:RegisterSkin('Blizzard_TradeWindow', AS.Blizzard_TradeWindow)
