--Emerald-Gaze Pendulm-Angel
function c249000381.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c249000381.drawcon)
	e3:SetOperation(c249000381.drawop)
	c:RegisterEffect(e3)
	--draw (pzone)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,249000381)
	e2:SetCondition(c249000381.condition)
	e2:SetCost(c249000381.cost)
	e2:SetOperation(c249000381.operation)
	c:RegisterEffect(e2)
end
function c249000381.confilter(c)
	return c:IsSetCard(0x1B7) and not c:IsCode(249000381)
end
function c249000381.drawcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return eg:GetCount()==1 and eg:GetFirst()==c
		and c:GetSummonType()==SUMMON_TYPE_PENDULUM and c:IsPreviousLocation(LOCATION_HAND)
		and Duel.IsExistingMatchingCard(c249000381.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c249000381.drawop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
end
function c249000381.condition(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	return tc and tc:IsSetCard(0x1B7)
end
function c249000381.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c249000381.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
end